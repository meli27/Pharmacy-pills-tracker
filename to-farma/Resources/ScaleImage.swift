//
//  ScaleImage.swift
//  to-farma
//
//  Created by Melissa Villalobos on 31/5/21.
//

import Foundation
import UIKit

class ScaledHeightImageView: UIImageView {
    private var aspectRatioConstraint: NSLayoutConstraint?

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    public override init(image: UIImage!) {
        super.init(image: image)
        self.setup()
    }

    public override init(image: UIImage!, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        self.setup()
    }

    override public var image: UIImage? {
        didSet {
            self.updateAspectRatioConstraint()
        }
    }

    private func setup() {
        self.contentMode = .scaleAspectFit
        self.updateAspectRatioConstraint()
    }

    private func updateAspectRatioConstraint() {
        if let update = self.aspectRatioConstraint {
            self.removeConstraint(update)
        }
        self.aspectRatioConstraint = nil

        if let imageSize = image?.size, imageSize.height != 0 {
            let aspectRatio = imageSize.width / imageSize.height
            let update = NSLayoutConstraint(
                item: self, attribute: .width,
                relatedBy: .equal,
                toItem: self, attribute: .height,
                multiplier: aspectRatio, constant: 0)
        
            self.addConstraint(update)
            self.aspectRatioConstraint = update
        }
    }
}
