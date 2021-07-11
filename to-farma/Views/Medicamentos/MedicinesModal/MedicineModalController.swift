//
//  MedicineModalController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 2/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class MedicineModalController: UIViewController {
    let contentView = MedicineModalView()
    let medicineTitle: String
    let dataSheet: String
    let disposeBag = DisposeBag()
 
    init(title: String?, dataSheet: String?) {
        self.medicineTitle = title ?? ""
        self.dataSheet = dataSheet ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = contentView
        let dataSheet = UIImageView()
        
        let medicineDataSheet = "https://app.tofarma.com/storage/"+(self.dataSheet)
        if let medecineImage = dataSheet.fetchImageFrom(url: medicineDataSheet) {
            dataSheet.image = medecineImage
        } else {
            dataSheet.image = R.image.toFarmaLogo()
        }
        
        dataSheet.contentMode = .scaleAspectFit
        contentView.dataSheet.addArrangedSubview(dataSheet)
    }
    
    override func viewDidLoad() {
        self.view = contentView
        super.viewDidLoad()
        
        Driver.just(self.medicineTitle)
            .drive(contentView.title.rx.text)
            .disposed(by: disposeBag)
    }
}
