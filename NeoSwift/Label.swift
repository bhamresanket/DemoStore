//
//  Label.swift
//  Esds Enlight
//
//  Created by esds on 3/4/17.
//  Copyright © 2017 Esds Solutions. All rights reserved.
//

import UIKit

class Label: UILabel {

    // FIXME: - properties
    var fontSize: CGFloat = 0
    var frameHeight: CGFloat = 0
    
    // FIXME: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // FIXME: - proportional font size adjustment
    override func layoutSubviews() {
        super.layoutSubviews()
        font = font.withSize(frame.height * (fontSize / frameHeight))
    }
}

class AttrLabel: UILabel {
    
    // FIXME: - properties
    var fontSize: CGFloat = 0
    var frameHeight: CGFloat = 0
    
    // FIXME: - proportional font size adjustment
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //        http://stackoverflow.com/questions/28496093/making-text-bold-using-attributed-string-in-swift
        //        http://stackoverflow.com/questions/3586871/bold-non-bold-text-in-a-single-uilabel
        //        http://www.b2cloud.com.au/tutorial/changing-font-size-of-an-nsattributedstring/
        //        http://stackoverflow.com/questions/30416859/changing-font-size-in-nsattributedstring-without-losing-html-style-swift
        //        http://stackoverflow.com/questions/19386849/looping-through-nsattributedstring-attributes-to-increase-font-size
        //        http://stackoverflow.com/questions/43252440/adjust-font-size-of-nsmutableattributedstring-proportional-to-uilabels-frame-he
        //        http://stackoverflow.com/questions/40480250/not-getting-justified-uilabel-attributed-text-properly
        //        http://stackoverflow.com/questions/25207373/changing-specific-texts-color-using-nsmutableattributedstring-in-swift
        
        guard let oldAttrText = attributedText else {
            return
        }
        
        let mutableAttributedText = NSMutableAttributedString(attributedString: oldAttrText)
        mutableAttributedText.beginEditing()
        
        mutableAttributedText.enumerateAttribute(NSFontAttributeName, in: NSRange(location: 0, length: mutableAttributedText.length), options: []) { (_ value: Any?, _ range: NSRange, _ stop: UnsafeMutablePointer<ObjCBool>) in
            if let attributeFont = value as? UIFont {
                let newFont = attributeFont.withSize(self.frame.height * (self.fontSize / self.frameHeight))
                mutableAttributedText.removeAttribute(NSFontAttributeName, range: range)
                mutableAttributedText.addAttribute(NSFontAttributeName, value: newFont, range: range)
            }
        }
        
        mutableAttributedText.endEditing()
        attributedText = mutableAttributedText
    }
}
