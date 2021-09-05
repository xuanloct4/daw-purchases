//
//  ProductCell.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/27/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var faceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var usersLabel: UILabel!
    @IBOutlet weak var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var userHeightConstraint: NSLayoutConstraint!
    
    var model: Product? {
        didSet {
            if let model = model {
                faceLabel.text = model.product?.face ?? ""
                priceLabel.text = "Price: \(String(describing: model.product?.price ?? 0))"
                sizeLabel.text = "Size: \(String(describing: model.product?.size ?? 0))"
                
                let recent = model.product?.recent ?? []
                usersLabel.text = "Purchased by:\n\(recent.unique().joined(separator: ", "))"
                userHeightConstraint.constant = usersLabel.actualHeight
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        translatesAutoresizingMaskIntoConstraints = false
        containerViewWidthConstraint.constant = Sizes.screenWidth
    }
}
