//
//  ProductsViewController.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

class ProductsViewController: UIViewController {
    static let floorPlanCell = "PedidosCell"
    private let contentView = ProductsView()
    private let viewModel = ProductsViewModel()
    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Productos>>!
    private let disposeBag = DisposeBag()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Productos>>(
              configureCell: { _, tableView, indexPath, product in
                guard let cell = tableView.dequeueReusableCell(withIdentifier:
                    "PedidosCell", for: indexPath) as? PedidosCell
                else {
                    return PedidosCell()
                }
                
                cell.priceLabel.rx.tapGesture()
                    .when(.recognized)
                    .asDriver(onErrorDriveWith: .empty())
                    .map { _ in product }
                    .debug("aaa", trimOutput: false)
                    .drive(self.viewModel.minusTapped)
                    .disposed(by: cell.disposeBag)
                
                cell.plus.rx.tap
                    .asDriver(onErrorDriveWith: .empty())
                    .map { _ in product }
                    .drive(self.viewModel.plusTapped)
                    .disposed(by: cell.disposeBag)
                
                let productLogo = "https://app.tofarma.com/storage/"+(product.logo ?? "")
                cell.pedidosImage.imageFromServerURL(productLogo, placeHolder: cell.pedidosImage.image)

                cell.titleLabel.text = product.name
                cell.priceLabel.text = "₡" + String(product.price ?? 0)
                
                return cell
           })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.setUpNavigationBar()
        self.view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
    
        navigationItem.leftBarButtonItem?.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                self?.backAction()
            })
            .disposed(by: disposeBag)
        
        contentView.pedidosTable.register(PedidosCell.self, forCellReuseIdentifier: "PedidosCell")
        
        contentView.pedidosTable.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        viewModel.products
            .startWith([])
            .map { $0.first?.items.isEmpty ?? true }
            .drive(contentView.pedidosTable.rx.isEmpty(message: "Por favor seleccionar una categoría."))
            .disposed(by: disposeBag)

        viewModel.products
            .drive(contentView.pedidosTable.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
                self?.contentView.pickerView.isHidden = true
            })
            .disposed(by: disposeBag)
        
        contentView.pickerText.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.contentView.pickerView.isHidden = false
            })
            .disposed(by: disposeBag)
        
        viewModel.categories
            .drive(self.contentView.pickerView.rx.itemTitles) { (_, category) in
                return category.name
            }
            .disposed(by: self.disposeBag)
        
        contentView.pickerView.rx.modelSelected(Category.self)
            .asDriver(onErrorDriveWith: Driver.empty())
            .compactMap { $0.first?.id }
            .drive(self.viewModel.selectedCategory)
            .disposed(by: disposeBag)
        
        viewModel.minusProduct
            .drive(onNext: {
                print("minus")
                print($0.name)
            })
            .disposed(by: disposeBag)
        
        viewModel.plusProduct
            .drive(onNext: {
                print("plus")
                print($0.name)
            })
            .disposed(by: disposeBag)
    }
}

extension ProductsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
