//
//  RectangleView.swift
//  to-farma
//
//  Created by Melissa Villalobos on 2/6/21.
//

import Foundation
import UIKit

class RectangleView: UIView {
    private var colour: UIColor!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func createBezierPath(width: Int, height: Int, positionX: Int, positionY: Int) -> UIBezierPath {
        let path = UIBezierPath(
            roundedRect: CGRect(x: positionX, y: positionY, width: width, height: height),
            byRoundingCorners: [.topLeft, .bottomLeft],
            cornerRadii: CGSize(width: 8, height: 8)
        )
        
        return path
    }
    
    func setup() {
        let shapeLayer2 = CAShapeLayer()
        shapeLayer2.path = createBezierPath(width: 300, height: 34, positionX: 190, positionY: 10).cgPath
        shapeLayer2.fillColor = Color.secondaryColor.cgColor
        self.layer.addSublayer(shapeLayer2)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createBezierPath(width: 400, height: 34, positionX: 90, positionY: 50).cgPath
        shapeLayer.fillColor = Color.greenBlueColor.cgColor
        self.layer.addSublayer(shapeLayer)
    
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
