//
//  Label+ActualHeight.swift
//  daw-purchases
//
//  Created by Tran Loc on 10/31/20.
//  Copyright © 2020 Tran Loc. All rights reserved.
//

import UIKit

extension UILabel {
    public var numberOfVisibleLines: Int {
        let rHeight: Int = lroundf(Float(self.actualHeight))
        let charSize: Int = lroundf(Float(self.font.pointSize))
        return rHeight / charSize
    }
    
    public var actualHeight: CGFloat {
        let textSize = CGSize(width: CGFloat(self.frame.size.width), height: CGFloat(MAXFLOAT))
        return self.sizeThatFits(textSize).height
    }
    
    public func calculateMaxLines() -> Int {
            let maxSize = CGSize(width: self.frame.size.width, height: CGFloat(Float.infinity))
            let charSize = font.lineHeight
            let text = (self.text ?? "") as NSString
            let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
            let linesRoundedUp = Int(ceil(textSize.height/charSize))
            return linesRoundedUp
        }
}
