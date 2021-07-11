//
//  MedicinesCell.swift
//  to-farma
//
//  Created by Melissa Villalobos on 27/6/21.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class MedicinesCell: UITableViewCell {
    var title = UILabel()
    var medicineImage = UIImageView()
    var medicineDescription = UILabel()
    var timeTitle = UILabel()
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayouts()
        prepareForReuse()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title.text = ""
        medicineImage.image = nil
        medicineDescription.text = ""
        timeTitle.text = ""
        self.disposeBag = DisposeBag()
    }
    
    func setLayouts() {
        let headerView = UIStackView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.axis = .horizontal
        headerView.spacing = 10
        self.addSubview(headerView)
    
        medicineImage.translatesAutoresizingMaskIntoConstraints = false
        headerView.addArrangedSubview(medicineImage)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            headerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            medicineImage.widthAnchor.constraint(equalToConstant: 100),
            medicineImage.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        let infoView = UIStackView()
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.axis = .vertical
        infoView.spacing = 4
        headerView.addArrangedSubview(infoView)
        
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        infoView.addArrangedSubview(title)
        
        medicineDescription.font = UIFont.systemFont(ofSize: 14)
        medicineDescription.translatesAutoresizingMaskIntoConstraints = false
        medicineDescription.numberOfLines = 0
        infoView.addArrangedSubview(medicineDescription)
    }
}
