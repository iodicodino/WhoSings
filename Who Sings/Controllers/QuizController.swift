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
        UIUtility.styleAsCardView(view)
        return view
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        return label
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsCardView(view)
        return view
    }()
    
    private let firstOptionButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(view)
        return view
    }()
    
    private let firstOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ciccio"
        return label
    }()
    
    private let secondOptionButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(view)
        return view
    }()
    
    private let secondOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pasticcio"
        return label
    }()
    
    private let thirdOptionButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(view)
        return view
    }()
    
    private let thirdOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lady Gaga"
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsSalmonButton(button)
        button.setTitle("Conferma", for: .normal)
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
        cardView.addSubview(firstOptionButton)
        firstOptionButton.addSubview(firstOptionLabel)
        cardView.addSubview(secondOptionButton)
        secondOptionButton.addSubview(secondOptionLabel)
        cardView.addSubview(thirdOptionButton)
        thirdOptionButton.addSubview(thirdOptionLabel)
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
        
        constraints.append(firstOptionButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.padding))
        constraints.append(firstOptionButton.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionButton.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(firstOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(firstOptionLabel.centerYAnchor.constraint(equalTo: firstOptionButton.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(firstOptionLabel.leadingAnchor.constraint(equalTo: firstOptionButton.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionLabel.trailingAnchor.constraint(equalTo: firstOptionButton.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(secondOptionButton.topAnchor.constraint(equalTo: firstOptionButton.bottomAnchor, constant: Constants.padding))
        constraints.append(secondOptionButton.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionButton.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(secondOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(secondOptionLabel.centerYAnchor.constraint(equalTo: secondOptionButton.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(secondOptionLabel.leadingAnchor.constraint(equalTo: secondOptionButton.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionLabel.trailingAnchor.constraint(equalTo: secondOptionButton.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(thirdOptionButton.topAnchor.constraint(equalTo: secondOptionButton.bottomAnchor, constant: Constants.padding))
        constraints.append(thirdOptionButton.leadingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(thirdOptionButton.trailingAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionButton.bottomAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(thirdOptionLabel.centerYAnchor.constraint(equalTo: thirdOptionButton.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(thirdOptionLabel.leadingAnchor.constraint(equalTo: thirdOptionButton.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(thirdOptionLabel.trailingAnchor.constraint(equalTo: thirdOptionButton.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(continueButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Constants.padding))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(continueButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Actions
    
    @objc func buttonContinue() {
        
    }
}
