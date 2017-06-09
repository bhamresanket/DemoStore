//
//  BaseController.swift
//  NeoSwift
//
//  Created by SGK Tech on 07/06/17.
//  Copyright © 2017 SgkTech. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    // FIXME: - properties
    var activeTextField: UITextField?
    var activeTextView: UITextView?
    var activeScrollView: UIScrollView?
    var isKeyboardShowing: Bool = false
    var kbAnimationTime: Double = 0.0
    
    // FIXME: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isKeyboardShowing = false
        kbAnimationTime = 0.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // FIXME: - handlers
    final func keyboardWillShow(notification: NSNotification) {
        if let nsNum = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            // https://stackoverflow.com/questions/27279032/swift-convert-object-that-is-nsnumber-to-double
            kbAnimationTime = nsNum.doubleValue
        }
        
        if isKeyboardShowing == true {
            return;
        }
        isKeyboardShowing = true
        
        guard let activeScrollView = self.activeScrollView else {
            return
        }
        
        guard let nsVal = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let kbSize = nsVal.cgRectValue.size
        
        var insets = activeScrollView.contentInset
        insets.bottom += kbSize.height
        activeScrollView.contentInset = insets
        
        insets = activeScrollView.scrollIndicatorInsets
        insets.bottom += kbSize.height
        activeScrollView.scrollIndicatorInsets = insets
        
        var viewBound = view.bounds
        viewBound.size.height -= (kbSize.height + 10)
        
        var activeRect: CGRect = .zero
        if let activeTextField = self.activeTextField {
            activeRect = view.convert(activeTextField.frame, from: activeTextField.superview)
        }
        else {
            if let activeTextView = self.activeTextView {
                activeRect = view.convert(activeTextView.frame, from: activeTextView.superview)
            }
        }
        
        var activeOrigin = activeRect.origin
        activeOrigin.y = activeRect.maxY
        
        if (!viewBound.contains(activeOrigin)) {
            activeScrollView.setContentOffset(CGPoint(x: 0, y: activeScrollView.contentOffset.y + (activeRect.maxY - viewBound.size.height)), animated: true)
        }
    }
    
    final func keyboardWillHide(notification: NSNotification) {
        if let nsNum = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber {
            // https://stackoverflow.com/questions/27279032/swift-convert-object-that-is-nsnumber-to-double
            kbAnimationTime = nsNum.doubleValue
        }
        
        if isKeyboardShowing == false {
            return;
        }
        isKeyboardShowing = false
        
        guard let activeScrollView = self.activeScrollView else {
            return
        }
        
        guard let nsVal = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else {
            return
        }
        let kbSize = nsVal.cgRectValue.size
        
        var insets = activeScrollView.contentInset
        insets.bottom -= kbSize.height
        activeScrollView.contentInset = insets
        
        insets = activeScrollView.scrollIndicatorInsets
        insets.bottom -= kbSize.height
        activeScrollView.scrollIndicatorInsets = insets
    }
    
    // FIXME: - alert
    func alert(title: String, message: String, pAction: String, nAction: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: pAction, style: .default) { (action: UIAlertAction) in
            self.onConfirm(title: title, action: pAction)
        })
        
        if let nAction = nAction {
            alert.addAction(UIAlertAction(title: nAction, style: .default) { (action: UIAlertAction) in
                self.onConfirm(title: title, action: nAction)
            })
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // FIXME: - alert confirmation
    func onConfirm(title: String, action: String) {
        print("Complete into derived class")
    }
}
