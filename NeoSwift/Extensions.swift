//
//  Extensions.swift
//  GuruGajanan
//
//  Created by SGK Tech on 03/06/17.
//  Copyright © 2017 SgkTech. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraints(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary["v\(index)"] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    @discardableResult
    func layout(
        _ leftItem: Any,
        _ leftAttribute: NSLayoutAttribute,
        _ relation: NSLayoutRelation,
        _ rightItem: Any,
        _ rightAttribute: NSLayoutAttribute,
        _ multiplier: CGFloat,
        _ constant: CGFloat
        ) -> NSLayoutConstraint {
        if let leftView = leftItem as? UIView {
            leftView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(
            item:       leftItem,
            attribute:  leftAttribute,
            relatedBy:  relation,
            toItem:     rightItem,
            attribute:  rightAttribute,
            multiplier: multiplier,
            constant:   constant
        )
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func layout(
        _ leftItem: Any,
        _ leftAttribute: NSLayoutAttribute,
        _ relation: NSLayoutRelation,
        _ rightItem: Any,
        _ rightAttribute: NSLayoutAttribute
        ) -> NSLayoutConstraint {
        if let leftView = leftItem as? UIView {
            leftView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(
            item:       leftItem,
            attribute:  leftAttribute,
            relatedBy:  relation,
            toItem:     rightItem,
            attribute:  rightAttribute,
            multiplier: 1,
            constant:   0
        )
        self.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func layout(
        _ leftItem: Any,
        _ leftAttribute: NSLayoutAttribute,
        _ relation: NSLayoutRelation,
        _ constant: CGFloat
        ) -> NSLayoutConstraint {
        if let leftView = leftItem as? UIView {
            leftView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraint = NSLayoutConstraint(
            item:       leftItem,
            attribute:  leftAttribute,
            relatedBy:  relation,
            toItem:     nil,
            attribute:  .notAnAttribute,
            multiplier: 1,
            constant:   constant
        )
        self.addConstraint(constraint)
        return constraint
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        let r: CGFloat = CGFloat((hex >> 16) & 0xFF)
        let g: CGFloat = CGFloat((hex >> 8) & 0xFF)
        let b: CGFloat = CGFloat(hex & 0xFF)
        
        self.init(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}

extension UIFont {
    
    static func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        for familyName in fontFamilyNames {
            print("------------------------------")
            print("Font Family Name = [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names = [\(names)]")
        }
    }
}

extension NSObject {
    
    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
