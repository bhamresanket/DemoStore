//
//  Button.swift
//  Esds Enlight
//
//  Created by esds on 3/4/17.
//  Copyright © 2017 Esds Solutions. All rights reserved.
//

import UIKit

class Button: UIButton {

    // FIXME: - properties
    var fontSize: CGFloat = 0
    var frameHeight: CGFloat = 0
    
    // FIXME: - proportional font size adjustment
    override func layoutSubviews() {
        super.layoutSubviews()
        if let titleLabel = self.titleLabel {
            titleLabel.font = titleLabel.font.withSize(frame.height * (fontSize / frameHeight))
        }
    }
}
