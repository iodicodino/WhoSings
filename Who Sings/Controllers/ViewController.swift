//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.questionMarkImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsSalmonButton(button)
        button.setTitle("Sono pronto. Vai!", for: .normal)
        button.addTarget(self, action: #selector(buttonStart), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Benvenuto su Who Sings!"
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "Inserisci il tuo nickname per giocare"
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
        textField.placeholder = "Inserisci il tuo nickname"
        textField.setLeftPaddingPoints(12)
        textField.setRightPaddingPoints(12)
        return textField
    }()
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.background
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(startButton)
        view.addSubview(textField)
        
        startButton.isEnabled = false
        startButton.isUserInteractionEnabled = false
        startButton.alpha = 0.5
        
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        addConstraints()
    }


    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(imageView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200))
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        constraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding))
        constraints.append(titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        constraints.append(messageLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(messageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        messageLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        
        constraints.append(textField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(textField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(textField.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(textField.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(textField.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        constraints.append(startButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Constants.padding))
        constraints.append(startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
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
    
    // MARK: - Actions
    
    @objc func buttonStart() {
        // Save User and start
        
        let user = User()
        user.name = textField.text
        
        dismiss(animated: true) {
            
            let next = QuizController()
            let navigation = UINavigationController(rootViewController: next)
            self.present(navigation, animated: true, completion: nil)
        }
    }
}

