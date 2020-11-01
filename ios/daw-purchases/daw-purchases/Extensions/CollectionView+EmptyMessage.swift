//
//  CollectionView+EmptyMessage.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/31/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let margin: CGFloat = 10
        let messageLabel = UILabel(frame: CGRect(x: 10, y: 0, width: self.bounds.size.width - 2*margin, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
