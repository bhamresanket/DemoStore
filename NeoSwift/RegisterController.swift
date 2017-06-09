//
//  RegisterController.swift
//  NeoSwift
//
//  Created by SGK Tech on 09/06/17.
//  Copyright © 2017 SgkTech. All rights reserved.
//


// Add all images with text field.
// Create enums for button titles


import UIKit

class RegisterController: BaseController, UITextFieldDelegate, UIGestureRecognizerDelegate {

    // FIXME: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navCon = self.navigationController {
            navCon.navigationBar.barTintColor = UIColor(hex: Constants.DARK_COLOR, alpha: 1)
            navCon.navigationBar.tintColor = UIColor.white
            navCon.navigationBar.barStyle = .black
        }
        navigationItem.title = "Register"
        
        activeScrollView = scrollView
        
        view.addGestureRecognizer(mainViewTapGesture)
        mainViewTapGesture.delegate = self
        
        labelMale.addGestureRecognizer(labelMaleTapGesture)
        labelMaleTapGesture.delegate = self
        
        labelFemale.addGestureRecognizer(labelFemaleTapGesture)
        labelFemaleTapGesture.delegate = self
        
        labelTerms.addGestureRecognizer(labelTermsTapGesture)
        labelTermsTapGesture.delegate = self
        
        textFirstName.delegate = self
        textLastName.delegate = self
        textEmail.delegate = self
        textPassword.delegate = self
        textConfirmPassword.delegate = self
        textPhoneNumber.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let navCon = self.navigationController {
            navCon.isNavigationBarHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activeScrollView = nil
        
        view.removeGestureRecognizer(mainViewTapGesture)
        mainViewTapGesture.delegate = nil
        
        labelMale.removeGestureRecognizer(labelMaleTapGesture)
        labelMaleTapGesture.delegate = nil
        
        labelFemale.removeGestureRecognizer(labelFemaleTapGesture)
        labelFemaleTapGesture.delegate = nil
        
        labelTerms.removeGestureRecognizer(labelTermsTapGesture)
        labelTermsTapGesture.delegate = nil
        
        textFirstName.delegate = nil
        textLastName.delegate = nil
        textEmail.delegate = nil
        textPassword.delegate = nil
        textConfirmPassword.delegate = nil
        textPhoneNumber.delegate = nil
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    // FIXME: - handlers
    func onButtonPressed(sender: Button) {
        guard let command = sender.titleLabel?.text else {
            return
        }
        
        if isKeyboardShowing && sender === buttonRegister {
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
        case "Male":
            buttonMale.isSelected = true
            buttonFemale.isSelected = false
            
        case "Female":
            buttonFemale.isSelected = true
            buttonMale.isSelected = false
            
        case "Terms":
            buttonCheckBox.isSelected = !buttonCheckBox.isSelected
            
        case "REGISTER":
            if let navCon = self.navigationController {
                navCon.popViewController(animated: true)
            }
            
        default:
            return
        }
    }
    
    func onScreenTap(gesture: UITapGestureRecognizer) {
        guard let tappedView = gesture.view else {
            return
        }
        
        if tappedView === view {
            if isKeyboardShowing {
                dismissKeyboard()
            }
        }
        else if tappedView === labelMale {
            performAction(for: "Male")
        }
        else if tappedView === labelFemale {
            performAction(for: "Female")
        }
        else if tappedView === labelTerms {
            performAction(for: "Terms")
        }
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
    
    private lazy var labelMaleTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onScreenTap(gesture: )))
        return tap
    }()
    
    private lazy var labelFemaleTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onScreenTap(gesture: )))
        return tap
    }()
    
    private lazy var labelTermsTapGesture: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onScreenTap(gesture: )))
        return tap
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
    
    private let textFirstName: TextField = {
        let textField = TextField()
        textField.placeholder = "First Name"
        textField.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.setValue(UIColor(white: 1, alpha: 0.5), forKeyPath: "_placeholderLabel.textColor")
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.fontSize = 20
        textField.frameHeight = 44
        textField.padding.left = 8
        textField.padding.right = 8
        textField.clipsToBounds = true
        return textField
    }()
    
    private let textLastName: TextField = {
        let textField = TextField()
        textField.placeholder = "Last Name"
        textField.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.setValue(UIColor(white: 1, alpha: 0.5), forKeyPath: "_placeholderLabel.textColor")
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        textField.fontSize = 20
        textField.frameHeight = 44
        textField.padding.left = 8
        textField.padding.right = 8
        textField.clipsToBounds = true
        return textField
    }()
    
    private let textEmail: TextField = {
        let textField = TextField()
        textField.placeholder = "Username"
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
    
    private let textConfirmPassword: TextField = {
        let textField = TextField()
        textField.placeholder = "Confirm Password"
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
    
    private let labelGender: Label = {
        let label = Label()
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 22)
        label.textColor = UIColor.white
        label.text = "Gender"
        label.fontSize = 22
        label.frameHeight = 24
        label.clipsToBounds = true
        return label
    }()
    
    private let labelFemale: Label = {
        let label = Label()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        label.textColor = UIColor.white
        label.text = "Female"
        label.fontSize = 20
        label.frameHeight = 24
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var buttonFemale: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "radiounfilled"), for: .normal)
        button.setBackgroundImage(UIImage(named: "radiofilled"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "radiofilled"), for: .selected)
        button.tintColor = UIColor.clear
        button.setTitle("Female", for: .normal)
        button.setTitleColor(UIColor.clear, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        button.fontSize = 20
        button.frameHeight = 24
        button.isSelected = false
        button.clipsToBounds = true
        return button
    }()
    
    private let labelMale: Label = {
        let label = Label()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        label.textColor = UIColor.white
        label.text = "Male"
        label.fontSize = 20
        label.frameHeight = 24
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var buttonMale: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "radiounfilled"), for: .normal)
        button.setBackgroundImage(UIImage(named: "radiofilled"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "radiofilled"), for: .selected)
        button.tintColor = UIColor.clear
        button.setTitle("Male", for: .normal)
        button.setTitleColor(UIColor.clear, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        button.fontSize = 20
        button.frameHeight = 24
        button.isSelected = true
        button.clipsToBounds = true
        return button
    }()
    
    private let textPhoneNumber: TextField = {
        let textField = TextField()
        textField.placeholder = "Phone Number"
        textField.font = UIFont(name: Constants.GOTHAM_MEDIUM, size: 20)
        textField.textColor = UIColor.white
        textField.tintColor = UIColor.white
        textField.setValue(UIColor(white: 1, alpha: 0.5), forKeyPath: "_placeholderLabel.textColor")
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.white.cgColor
        textField.keyboardType = .phonePad
        textField.autocorrectionType = .no
        textField.fontSize = 20
        textField.frameHeight = 44
        textField.padding.left = 8
        textField.padding.right = 8
        textField.clipsToBounds = true
        return textField
    }()
    
    private let labelTerms: Label = {
        let label = Label()
        label.textAlignment = .right
        label.numberOfLines = 1
        label.font = UIFont(name: Constants.GOTHAM_BOLD, size: 16)
        label.textColor = UIColor.white
        label.text = "I agree the Terms & Conditions"
        label.fontSize = 16
        label.frameHeight = 20
        label.isUserInteractionEnabled = true
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var buttonCheckBox: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.setBackgroundImage(UIImage(named: "uncheck"), for: .normal)
        button.setBackgroundImage(UIImage(named: "check"), for: .highlighted)
        button.setBackgroundImage(UIImage(named: "check"), for: .selected)
        button.tintColor = UIColor.clear
        button.setTitle("Terms", for: .normal)
        button.setTitleColor(UIColor.clear, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_BOLD, size: 16)
        button.fontSize = 16
        button.frameHeight = 20
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var buttonRegister: Button = {
        let button = Button(type: .system)
        button.addTarget(self, action: #selector(onButtonPressed(sender: )), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(UIColor(hex: Constants.DARK_COLOR, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.GOTHAM_BOLD, size: 28)
        button.layer.cornerRadius = 7
        button.fontSize = 28
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

        scrollView.addSubview(labelNeoStore)
        scrollView.addSubview(textFirstName)
        scrollView.addSubview(textLastName)
        scrollView.addSubview(textEmail)
        scrollView.addSubview(textPassword)
        scrollView.addSubview(textConfirmPassword)
        scrollView.addSubview(labelGender)
        scrollView.addSubview(labelFemale)
        scrollView.addSubview(buttonFemale)
        scrollView.addSubview(labelMale)
        scrollView.addSubview(buttonMale)
        scrollView.addSubview(textPhoneNumber)
        scrollView.addSubview(labelTerms)
        scrollView.addSubview(buttonCheckBox)
        scrollView.addSubview(buttonRegister)
        scrollView.addSubview(viewBottomSpare)
        
        let heightFactor = max(view.frame.height, 568.0) / Constants.REF_HEIGHT
        
        // labelNeoStore
        scrollView.layout(labelNeoStore, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(labelNeoStore, .centerY, .equal, scrollView, .top, 1, (128 * heightFactor))
        scrollView.layout(labelNeoStore, .width, .equal, scrollView, .width, (334.0 / Constants.REF_WIDTH), 0)
        labelNeoStore.layout(labelNeoStore, .height, .equal, labelNeoStore, .width, (64.0 / 334.0), 0)
        
        // textFirstName
        scrollView.layout(textFirstName, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textFirstName, .centerY, .equal, labelNeoStore, .centerY, 1, (74 * heightFactor))
        scrollView.layout(textFirstName, .width, .equal, labelNeoStore, .width)
        textFirstName.layout(textFirstName, .height, .equal, textFirstName, .width, (44.0 / 334.0), 0)
        
        // textLastName
        scrollView.layout(textLastName, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textLastName, .centerY, .equal, textFirstName, .centerY, 1, (64 * heightFactor))
        scrollView.layout(textLastName, .width, .equal, textFirstName, .width)
        scrollView.layout(textLastName, .height, .equal, textFirstName, .height)
        
        // textEmail
        scrollView.layout(textEmail, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textEmail, .centerY, .equal, textLastName, .centerY, 1, (64 * heightFactor))
        scrollView.layout(textEmail, .width, .equal, textFirstName, .width)
        scrollView.layout(textEmail, .height, .equal, textFirstName, .height)
        
        // textPassword
        scrollView.layout(textPassword, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textPassword, .centerY, .equal, textEmail, .centerY, 1, (64 * heightFactor))
        scrollView.layout(textPassword, .width, .equal, textFirstName, .width)
        scrollView.layout(textPassword, .height, .equal, textFirstName, .height)
        
        // textConfirmPassword
        scrollView.layout(textConfirmPassword, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textConfirmPassword, .centerY, .equal, textPassword, .centerY, 1, (64 * heightFactor))
        scrollView.layout(textConfirmPassword, .width, .equal, textFirstName, .width)
        scrollView.layout(textConfirmPassword, .height, .equal, textFirstName, .height)
        
        // labelGender
        scrollView.layout(labelGender, .left, .equal, textConfirmPassword, .left, 1, 8)
        scrollView.layout(labelGender, .centerY, .equal, textConfirmPassword, .centerY, 1, (62 * heightFactor))
        scrollView.layout(labelGender, .width, .equal, scrollView, .width, (100.0 / Constants.REF_WIDTH), 0)
        labelGender.layout(labelGender, .height, .equal, labelGender, .width, (24.0 / 100.0), 0)
        
        // labelFemale
        scrollView.layout(labelFemale, .right, .equal, textConfirmPassword, .right, 1, -8)
        scrollView.layout(labelFemale, .centerY, .equal, labelGender, .centerY)
        scrollView.layout(labelFemale, .width, .equal, scrollView, .width, (75.0 / Constants.REF_WIDTH), 0)
        scrollView.layout(labelFemale, .height, .equal, labelGender, .height)
        
        // buttonFemale
        scrollView.layout(buttonFemale, .right, .equal, labelFemale, .left, 1, -4)
        scrollView.layout(buttonFemale, .centerY, .equal, labelGender, .centerY)
        scrollView.layout(buttonFemale, .width, .equal, labelGender, .height)
        scrollView.layout(buttonFemale, .height, .equal, labelGender, .height)
        
        // labelMale
        scrollView.layout(labelMale, .right, .equal, buttonFemale, .left, 1, -12)
        scrollView.layout(labelMale, .centerY, .equal, labelGender, .centerY)
        scrollView.layout(labelMale, .width, .equal, scrollView, .width, (50.0 / Constants.REF_WIDTH), 0)
        scrollView.layout(labelMale, .height, .equal, labelGender, .height)
        
        // buttonMale
        scrollView.layout(buttonMale, .right, .equal, labelMale, .left, 1, -4)
        scrollView.layout(buttonMale, .centerY, .equal, labelGender, .centerY)
        scrollView.layout(buttonMale, .width, .equal, labelGender, .height)
        scrollView.layout(buttonMale, .height, .equal, labelGender, .height)
        
        // textPhoneNumber
        scrollView.layout(textPhoneNumber, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(textPhoneNumber, .centerY, .equal, labelGender, .centerY, 1, (58 * heightFactor))
        scrollView.layout(textPhoneNumber, .width, .equal, textFirstName, .width)
        scrollView.layout(textPhoneNumber, .height, .equal, textFirstName, .height)
        
        // labelTerms
        scrollView.layout(labelTerms, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(labelTerms, .centerY, .equal, textPhoneNumber, .centerY, 1, (56 * heightFactor))
        scrollView.layout(labelTerms, .width, .equal, scrollView, .width, (280.0 / Constants.REF_WIDTH), 0)
        labelTerms.layout(labelTerms, .height, .equal, labelTerms, .width, (20.0 / 280.0), 0)
        
        // buttonCheckBox
        scrollView.layout(buttonCheckBox, .left, .equal, labelTerms, .left)
        scrollView.layout(buttonCheckBox, .top, .equal, labelTerms, .top)
        scrollView.layout(buttonCheckBox, .width, .equal, labelTerms, .height)
        scrollView.layout(buttonCheckBox, .height, .equal, labelTerms, .height)
        
        // buttonRegister
        scrollView.layout(buttonRegister, .centerX, .equal, scrollView, .centerX)
        scrollView.layout(buttonRegister, .centerY, .equal, labelTerms, .centerY, 1, (54 * heightFactor))
        scrollView.layout(buttonRegister, .width, .equal, labelNeoStore, .width)
        buttonRegister.layout(buttonRegister, .height, .equal, buttonRegister, .width, (64.0 / 334.0), 0)

        // viewBottomSpare
        scrollView.layout(viewBottomSpare, .left, .equal, scrollView, .left)
        scrollView.layout(viewBottomSpare, .top, .equal, buttonRegister, .bottom)
        scrollView.layout(viewBottomSpare, .width, .equal, scrollView, .width)
        viewBottomSpare.layout(viewBottomSpare, .height, .greaterThanOrEqual, 20)
        scrollView.layout(viewBottomSpare, .bottom, .equal, scrollView, .bottom)
        
        view.layoutIfNeeded()
    }
}











