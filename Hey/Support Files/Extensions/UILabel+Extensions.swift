//
//  UILabel+Extensions.swift
//  Ohana
//
//  Created by Mu Yu on 6/27/22.
//

import UIKit

extension UILabel {
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        let textAlignment = self.textAlignment
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
            self.textAlignment = textAlignment
        }
    }
}
