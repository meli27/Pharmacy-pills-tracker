//
//  MedicinesViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 19/6/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

// Falta proxima visita

class MedicineViewController: UIViewController {
    let contentView = MedicineView()
    var viewModel = MedicineViewModel()
    var medicineTableView = UITableView()
    private var dataSource: RxTableViewSectionedReloadDataSource<MedicationSection>!
    let disposeBag = DisposeBag()
 
    init() {
        super.init(nibName: nil, bundle: nil)
        
        dataSource = RxTableViewSectionedReloadDataSource<MedicationSection>(configureCell: { _, tableView, indexPath, medication -> UITableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier:
                "MedicineCell", for: indexPath) as? MedicinesCell
            else {
                return MedicinesCell()
            }
            let medicineLogo = "https://app.tofarma.com/storage/"+(medication.medicine?.logo ?? "")
            cell.medicineImage.imageFromServerURL(medicineLogo, placeHolder: cell.medicineImage.image)

            cell.title.text = medication.medicine?.name
            cell.medicineDescription.text = medication.dose
            
            cell.rx.tapGesture()
                .when(.recognized)
                .asDriver(onErrorDriveWith: Driver.empty())
                .compactMap{ _ in (title: medication.medicine?.name, dataSheet: medication.medicine?.dataSheet) }
                .drive(self.viewModel.touchDataSheet)
                .disposed(by: cell.disposeBag)
            
            return cell
        })
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
        
        contentView.mainStack.addArrangedSubview(medicineTableView)
    
    }
    
    override func viewDidLoad() {
        self.view = contentView
        super.viewDidLoad()
        
        medicineTableView.register(MedicinesCell.self, forCellReuseIdentifier: "MedicineCell")
        
        medicineTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.medications
            .drive(self.medicineTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.nextVisit
            .drive(contentView.nextVisit.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.dataSheet
            .drive(onNext: { title, dataSheet in
                guard
                    let title = title,
                    let dataSheet = dataSheet
                else { return }
                let vc = MedicineModalController(title: title, dataSheet: dataSheet)
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension MedicineViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = Color.secondaryColor
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = .black
    }
}
