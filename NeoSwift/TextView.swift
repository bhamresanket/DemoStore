//
//  TextView.swift
//  ENLight
//
//  Created by esds on 4/20/17.
//  Copyright © 2017 Esds Solutions. All rights reserved.
//

import UIKit

class TextView: UITextView {

    // FIXME: - properties
    var fontSize: CGFloat = 0
    var frameHeight: CGFloat = 0
    var placeholderText: String?
    var placeholderTextColor = UIColor(hex: 0xC7C7CD, alpha: 1)
    var normalTextColor = UIColor(hex: 0xF1F1F1, alpha: 1)
    
    // FIXME: - proportional font size adjustment
    override func layoutSubviews() {
        super.layoutSubviews()
        if let font = self.font {
            self.font = font.withSize(frame.height * (fontSize / frameHeight))
        }
    }
}
