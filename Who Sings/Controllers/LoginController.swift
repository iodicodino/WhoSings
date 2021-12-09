//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {

    var delegate: LoginControllerDelegate?
    
    
    // MARK: - UI Elements
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let contentView = CustomView()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.questionMarkImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let startButton: SalmonButton = {
        let button = SalmonButton()
        button.setTitle("loginController.startButton".localized, for: .normal)
        button.addTarget(self, action: #selector(buttonStart), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "loginController.label.title".localized
        return label
    }()
    
    private let messageLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "loginController.label.message".localized
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        UIUtility.addDefaultBorder(textField)
        UIUtility.addCornerRadius(textField, withRadius: Constants.buttonCornerRadius)
        textField.backgroundColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : Constants.border])
        textField.placeholder = "loginController.textField.placeholder".localized
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        return textField
    }()
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Keyboard handler
        
        initializeKeyboardHandler()
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // UI
        view.backgroundColor = Constants.background
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(messageLabel)
        contentView.addSubview(startButton)
        contentView.addSubview(textField)
        
        startButton.isEnabled = false
        startButton.isUserInteractionEnabled = false
        startButton.alpha = 0.5
        
        addConstraints()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }

    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        constraints.append(scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        
        constraints.append(contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor))
        constraints.append(contentView.topAnchor.constraint(equalTo: scrollView.topAnchor))
        constraints.append(contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor))
        constraints.append(contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor))
        constraints.append(contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor))
        
        constraints.append(imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding))
        constraints.append(imageView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(imageView.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 200))
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding))
        constraints.append(titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.padding))
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        constraints.append(messageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        constraints.append(messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(messageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -Constants.padding))
        messageLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        constraints.append(textField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        constraints.append(textField.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        constraints.append(startButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.padding))
        constraints.append(startButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(startButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        let heightButtonAnchor = startButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding)
        heightButtonAnchor.priority = .defaultLow
        constraints.append(heightButtonAnchor)
        constraints.append(startButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Textfield Delegate
    
    @objc func textFieldDidChange() {
        if let isEmpty = textField.text?.isEmpty, !isEmpty {
            // Button enabled
            startButton.isEnabled = true
            startButton.isUserInteractionEnabled = true
            startButton.alpha = 1
        } else {
            // Button disabled
            startButton.isEnabled = false
            startButton.isUserInteractionEnabled = false
            startButton.alpha = 0.5
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Actions
    
    @objc func buttonStart() {
        // Save User and start
        guard let username = textField.text else { return }
        
        let isAvailable = UserUtility.checkUsernameAvailable(username)
        
        let user = User()
        user.name = textField.text
        
        if isAvailable {
            UserUtility.setConnectedUser(user)
            UserUtility.addUserToStored(user)
            
            self.delegate?.didStartGame(self)
            self.dismiss(animated: true)
        } else {
            UIUtility.showConfirmationAlert(title: "alert.title.userNotAvailable", message: "alert.message.userNotAvailable", buttonOk: "alert.yesButton.userNotAvailable", buttonClose: "alert.noButton.userNotAbailable", controller: self) {
                
                if let storedUser = UserUtility.getUserFromStored(user) {
                    UserUtility.setConnectedUser(storedUser)
                    
                    self.delegate?.didStartGame(self)
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
    // MARK: - Keyboard notifications
    
    @objc func keyboardWillAppear(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            // Change scrollview's insets to correct visualization while keyboard is shown
            self.scrollView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }

    @objc func keyboardWillDisappear() {
        // Reset keyboard insets
        self.scrollView.contentInset = .zero
    }
}

protocol LoginControllerDelegate: NSObjectProtocol {
    func didStartGame(_ sender: LoginController)
}

extension LoginController {
    
    func initializeKeyboardHandler(){
        //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }
}
