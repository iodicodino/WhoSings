//
//  QuizController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit

class QuizController: UIViewController {
    
    // MARK: - UI Elements
    
    private let timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstOptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let firstOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let secondOptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let secondOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let thirdOptionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let thirdOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsSalmonButton(button)
        button.setTitle("Sono pronto. Vai!", for: .normal)
        button.addTarget(self, action: #selector(buttonContinue), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.background
        
        view.addSubview(timerView)
        timerView.addSubview(timerLabel)
        view.addSubview(cardView)
        cardView.addSubview(firstOptionView)
        firstOptionView.addSubview(firstOptionLabel)
        cardView.addSubview(secondOptionView)
        secondOptionView.addSubview(secondOptionLabel)
        cardView.addSubview(thirdOptionView)
        thirdOptionView.addSubview(thirdOptionLabel)
        view.addSubview(continueButton)
        
        continueButton.isEnabled = false
        continueButton.isUserInteractionEnabled = false
        continueButton.alpha = 0.5
        
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(timerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(timerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(timerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(timerView.heightAnchor.constraint(equalToConstant: 80))
        
        constraints.append(cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(cardView.topAnchor.constraint(equalTo: timerView.bottomAnchor, constant: Constants.padding))
        constraints.append(cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(firstOptionView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.padding))
        constraints.append(firstOptionView.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionView.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(firstOptionView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(firstOptionLabel.centerYAnchor.constraint(equalTo: firstOptionView.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(firstOptionLabel.leadingAnchor.constraint(equalTo: firstOptionView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionLabel.trailingAnchor.constraint(equalTo: firstOptionView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(secondOptionView.topAnchor.constraint(equalTo: firstOptionView.bottomAnchor, constant: Constants.padding))
        constraints.append(secondOptionView.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionView.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(secondOptionView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(secondOptionLabel.centerYAnchor.constraint(equalTo: secondOptionView.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(secondOptionLabel.leadingAnchor.constraint(equalTo: secondOptionView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionLabel.trailingAnchor.constraint(equalTo: secondOptionView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(thirdOptionView.topAnchor.constraint(equalTo: secondOptionView.bottomAnchor, constant: Constants.padding))
        constraints.append(thirdOptionView.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(thirdOptionView.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionView.bottomAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(continueButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Constants.padding))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    @objc func buttonContinue() {
        
    }
}
