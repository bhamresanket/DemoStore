//
//  LoginController.swift
//  NeoSwift
//
//  Created by SGK Tech on 07/06/17.
//  Copyright © 2017 SgkTech. All rights reserved.
//
/*
 For anyone using a UINavigationController:
 
 The UINavigationController does not forward on preferredStatusBarStyle calls to its child view controllers. Instead it manages its own state - as it should, it is drawing at the top of the screen where the status bar lives and so should be responsible for it. Therefor implementing preferredStatusBarStyle in your VCs within a nav controller will do nothing - they will never be called.
 
 The trick is what the UINavigationController uses to decide what to return for UIStatusBarStyleDefault or UIStatusBarStyleLightContent. It bases this on it's UINavigationBar.barStyle. The default (UIBarStyleDefault) results in the dark foreground UIStatusBarStyleDefault status bar. And UIBarStyleBlack will give a UIStatusBarStyleLightContent status bar.
 
 TL;DR:
 
 If you want UIStatusBarStyleLightContent on a UINavigationController use:
 
 self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
 
 // http://tobiashelmri.ch/swift,/ios/2016/12/08/hiding-the-status-bar-smoothly-in-ios-10.html
 */


// Create enums for button titles
// Add all images with text field.


import UIKit

class LoginController: BaseController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    // FIXME: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navCon = self.navigationController {
            navCon.isNavigationBarHidden = true
            //            navCon.navigationBar.barTintColor = UIColor(hex: Constants.DARK_COLOR, alpha: 1)
            //            navCon.navigationBar.tintColor = UIColor.white
            //            navCon.navigationBar.barStyle = .black
        }
        navigationItem.title = ""
        
        activeScrollView = scrollView
        
        view.addGestureRecognizer(mainViewTapGesture)
        mainViewTapGesture.delegate = self
        
        textEmail.delegate = self
        textPassword.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activeScrollView = nil
        
        view.removeGestureRecognizer(mainViewTapGesture)
        mainViewTapGesture.delegate = nil
        
        textEmail.delegate = nil
        textPassword.delegate = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // FIXME: - handlers
    func onButtonPressed(sender: Button) {
        guard let command = sender.titleLabel?.text else {
            return
        }
        
        if isKeyboardShowing {
            dismissKeyboard()
            delay(kbAnimationTime, closure: { 
                self.performAction(for: command)
            })
        }
        else {
            performAction(for: command)
        }
    }
    
    private func performAction(for command: String) {
        switch command {
        case "LOGIN":
            print("Login Pressed!")
            
        case "Forgot Password?":
            print("Forgot Password Pressed!")
            
        case "+":
            if let navCon = self.navigationController {
                navCon.pushViewController(RegisterController(), animated: true)
            }
            
        default:
            return
        }
    }
    
    func onScreenTap(gesture: UITapGestureRecognizer) {
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        if let textField = activeTextField {
            textField.resignFirstResponder()
        } else {
            if let textView = activeTextView {
                textView.resignFirstResponder()
            }
        }
    }
    
    // FIXME: - custom overriden
    override func onConfirm(title: String, action: String) {
        
    }
    
    // FIXME: - UIGestureRecognizer delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // https://stackoverflow.com/questions/40388337/swift-3-how-to-verify-class-type-of-object
        if let touchedView = touch.view {
            if touchedView is Button || touchedView is TextField {
                return false
            }
        }
        
        return true
    }
    
    // FIXME: - UITextField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    // FIXME: - status bar configuration
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // FIXME: - create views
    private lazy var mainViewTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onScreenTap(gesture: )))
        return tap
    }()
    
    private let statusBarBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: Constants.DARK_COLOR, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(hex: Constants.DARK_COLOR, alpha: 1)
        scroll.delaysContentTouches = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isPagingEnabled = false
        scroll.clipsToBounds = true
        return scroll
    }()

    private let labelNeoStore: Label = {
        let label = Label()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_BOLD, size: 50)
        label.textColor = UIColor.white
        label.text = "NeoSTORE"
        label.fontSize = 50
        label.frameHeight = 64
        label.clipsToBounds = true
        return label
    }()
    
    // https://stackoverflow.com/questions/32537867/swift-uitextfield-icon-position-set
    private let textEmail: TextField = {
        let textField = TextField()
        textField.placeholder = "Username"
        //        textField.text = "sanket@sgk.com"
        textField.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.setValue(UIColor(white: 1, alpha: 0.5), forKeyPath: "_placeholderLabel.textColor")
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.fontSize = 20
        textField.frameHeight = 44
        textField.padding.left = 8
        textField.padding.right = 8
        textField.clipsToBounds = true
        return textField
    }()
    
    private let textPassword: TextField = {
        let textField = TextField()
        textField.placeholder = "Password"
        //        textField.text = "gajanan211991"
        textField.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.setValue(UIColor(white: 1, alpha: 0.5), forKeyPath: "_placeholderLabel.textColor")
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.fontSize = 20
        textField.frameHeight = 44
        textField.padding.left = 8
        textField.padding.right = 8
        textField.clipsToBounds = true
        return textField
    }()
    
    private lazy var buttonLogin: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(UIColor(hex: Constants.DARK_COLOR, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_BOLD, size: 28)
        button.layer.cornerRadius = 7
        button.fontSize = 28
        button.frameHeight = 56
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var buttonForgotPassword: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.backgroundColor = UIColor.clear
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        button.fontSize = 20
        button.frameHeight = 30
        button.clipsToBounds = true
        return button
    }()

    private let labelQueAccount: Label = {
        let label = Label()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_BOLD, size: 18)
        label.textColor = UIColor.white
        label.text = "DONT HAVE AN ACCOUNT?"
        label.fontSize = 18
        label.frameHeight = 24
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var buttonRegisterNew: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.backgroundColor = UIColor(hex: 0x9E0100, alpha: 1)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GUJARATI_SANGAM, size: 56)
        button.fontSize = 56
        button.frameHeight = 56
        button.clipsToBounds = true
        return button
    }()

    private let viewBottomSpare: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.clipsToBounds = true
        return view
    }()

    // FIXME: - define constraints
    private func setupUI() {
        view.addSubview(scrollView)
        
        // scrollView
        view.layout(scrollView, .left, .equal, view, .left)
        view.layout(scrollView, .top, .equal, view, .top)
        view.layout(scrollView, .width, .equal, view, .width)
        view.layout(scrollView, .height, .equal, view, .height)
        
        if let navCon = self.navigationController {
            navCon.view.addSubview(statusBarBackground)
            
            // statusBarBackground
            navCon.view.layout(statusBarBackground, .left, .equal, navCon.view, .left)
            navCon.view.layout(statusBarBackground, .top, .equal, navCon.view, .top)
            navCon.view.layout(statusBarBackground, .width, .equal, navCon.view, .width)
            statusBarBackground.layout(statusBarBackground, .height, .equal, 20)
        }
        
        scrollView.addSubview(labelNeoStore)
        scrollView.addSubview(textEmail)
        scrollView.addSubview(textPassword)
        scrollView.addSubview(buttonLogin)
        scrollView.addSubview(buttonForgotPassword)
        scrollView.addSubview(labelQueAccount)
        scrollView.addSubview(buttonRegisterNew)
        scrollView.addSubview(viewBottomSpare)
        
        let heightFactor = max(view.frame.height, 568.0) / Constants.REF_HEIGHT
        
        // textPassword
        scrollView.layout(textPassword, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textPassword, .bottom, .equal, scrollView, .centerY)
        scrollView.layout(textPassword, .width, .equal, scrollView, .width, (334.0 / Constants.REF_WIDTH), 0)
        textPassword.layout(textPassword, .height, .equal, textPassword, .width, (44.0 / 334.0), 0)
        
        // textEmail
        scrollView.layout(textEmail, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textEmail, .centerY, .equal, textPassword, .centerY, 1, -(64 * heightFactor))
        scrollView.layout(textEmail, .width, .equal, textPassword, .width)
        scrollView.layout(textEmail, .height, .equal, textPassword, .height)
        
        // labelNeoStore
        scrollView.layout(labelNeoStore, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(labelNeoStore, .centerY, .equal, textEmail, .centerY, 1, -(94 * heightFactor))
        scrollView.layout(labelNeoStore, .width, .equal, textPassword, .width)
        labelNeoStore.layout(labelNeoStore, .height, .equal, labelNeoStore, .width, (64.0 / 334.0), 0)
        
        // buttonLogin
        scrollView.layout(buttonLogin, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(buttonLogin, .centerY, .equal, textPassword, .centerY, 1, (90 * heightFactor))
        scrollView.layout(buttonLogin, .width, .equal, textPassword, .width)
        buttonLogin.layout(buttonLogin, .height, .equal, buttonLogin, .width, (56.0 / 334.0), 0)
        
        // buttonForgotPassword
        scrollView.layout(buttonForgotPassword, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(buttonForgotPassword, .centerY, .equal, buttonLogin, .centerY, 1, (59 * heightFactor))
        scrollView.layout(buttonForgotPassword, .width, .equal, scrollView, .width, (254.0 / Constants.REF_WIDTH), 0)
        buttonForgotPassword.layout(buttonForgotPassword, .height, .equal, buttonForgotPassword, .width, (30.0 / 254.0), 0)
        
        // buttonRegisterNew
        scrollView.layout(buttonRegisterNew, .right, .equal, scrollView, .left, 1, (view.frame.width - 20))
        scrollView.layout(buttonRegisterNew, .bottom, .equal, scrollView, .top, 1, (view.frame.height - 20))
        scrollView.layout(buttonRegisterNew, .width, .equal, scrollView, .width, (56.0 / Constants.REF_WIDTH), 0)
        buttonRegisterNew.layout(buttonRegisterNew, .height, .equal, buttonRegisterNew, .width)
        
        // labelQueAccount
        scrollView.layout(labelQueAccount, .left, .equal, scrollView, .left, 1, 20)
        scrollView.layout(labelQueAccount, .centerY, .equal, buttonRegisterNew, .centerY)
        scrollView.layout(labelQueAccount, .width, .equal, scrollView, .width, (270.0 / Constants.REF_WIDTH), 0)
        labelQueAccount.layout(labelQueAccount, .height, .equal, labelQueAccount, .width, (24.0 / 270.0), 0)
        
        // viewBottomSpare
        scrollView.layout(viewBottomSpare, .left, .equal, scrollView, .left)
        scrollView.layout(viewBottomSpare, .top, .equal, buttonRegisterNew, .bottom)
        scrollView.layout(viewBottomSpare, .width, .equal, scrollView, .width)
        viewBottomSpare.layout(viewBottomSpare, .height, .greaterThanOrEqual, 20)
        scrollView.layout(viewBottomSpare, .bottom, .equal, scrollView, .bottom)
        
        view.layoutIfNeeded()
    }
}
