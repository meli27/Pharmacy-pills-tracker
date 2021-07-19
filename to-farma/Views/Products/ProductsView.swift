//
//  ProductsView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 17/7/21.
//

import Foundation
import UIKit

class ProductsView: UIView {
    let titleLabel = UILabel()
    let mainStackView = UIStackView()
    let tableStack = UIStackView()
    let addButton = UIButton()
    let pickerView = UIPickerView()
    let headerContainer = UIView()
    let pickerText = DropdownPickerView()
    let searchBar = SearchBarView()
    var pedidosTable: UITableView!

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 8
        self.addSubview(mainStackView)
        
        mainStackView.constrainToSafeEdges(to: self, padding: UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 16))
        
        let title = UILabel()
        title.text = R.string.localizable.pedidos_titulo()
        title.font = UIFont.boldSystemFont(ofSize: 28)
        title.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(title)
      
        let rectangleYellow = RectangleView()
        rectangleYellow.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(rectangleYellow)
        
        let headerStack = UIStackView()
        headerStack.translatesAutoresizingMaskIntoConstraints = false
        headerStack.axis = .horizontal
        headerStack.distribution = .fillEqually
        headerStack.spacing = 8
        mainStackView.addArrangedSubview(headerStack)
      
        pickerText.translatesAutoresizingMaskIntoConstraints = false
        pickerText.viewModel.setPlaceholder.accept(R.string.localizable.pedidos_categorias())
        headerStack.addArrangedSubview(pickerText)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        headerStack.addArrangedSubview(searchBar)
          
        tableStack.translatesAutoresizingMaskIntoConstraints = false
        tableStack.axis = .vertical
        tableStack.spacing = 8
        mainStackView.addArrangedSubview(tableStack)
        
        pedidosTable = UITableView()
        pedidosTable.backgroundColor = .clear
            //  floorPlanCollection.register(FloorPlanCell.self, forCellWithReuseIdentifier: FloorPlanViewController.floorPlanCell)
        pedidosTable.translatesAutoresizingMaskIntoConstraints = false
        tableStack.addArrangedSubview(pedidosTable)
        
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.isHidden = true
        pickerView.backgroundColor = Color.messageGray
        self.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
