//
//  TextField.swift
//  Esds Enlight
//
//  Created by esds on 3/4/17.
//  Copyright © 2017 Esds Solutions. All rights reserved.
//

import UIKit

class TextField: UITextField {

    // FIXME: - properties
    var fontSize: CGFloat = 0
    var frameHeight: CGFloat = 0
    var padding: UIEdgeInsets = .zero
    
    // FIXME: - proportional font size adjustment
    override func layoutSubviews() {
        super.layoutSubviews()
        if let font = self.font {
            self.font = font.withSize(frame.height * (fontSize / frameHeight))
        }
    }
    
    // FIXME: - text field padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, padding)
        if rightViewMode == .always || rightViewMode == .unlessEditing {
            if let rightView = self.rightView {
                rect.size.width -= rightView.frame.width
            }
        }
        if leftViewMode == .always || leftViewMode == .unlessEditing {
            if let leftView = self.leftView {
                rect.size.width -= leftView.frame.width
            }
        }
        return rect
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, padding)
        if rightViewMode == .always || rightViewMode == .unlessEditing {
            if let rightView = self.rightView {
                rect.size.width -= rightView.frame.width
            }
        }
        if leftViewMode == .always || leftViewMode == .unlessEditing {
            if let leftView = self.leftView {
                rect.size.width -= leftView.frame.width
            }
        }
        return rect
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = UIEdgeInsetsInsetRect(bounds, padding)
        if rightViewMode == .always || rightViewMode == .whileEditing {
            if let rightView = self.rightView {
                rect.size.width -= rightView.frame.width
            }
        }
        if leftViewMode == .always || leftViewMode == .whileEditing {
            if let leftView = self.leftView {
                rect.size.width -= leftView.frame.width
            }
        }
        return rect
    }
}
