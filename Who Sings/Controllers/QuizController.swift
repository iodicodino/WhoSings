//
//  QuizController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit

class QuizController: UIViewController {
    
    // MARK: - Initializers
    
    public var line: String!
    public var track: Track!
    
    public var delegate: QuizControllerDelegate?
    
    // MARK: - Private var
    
    private var options: [Option] = []
    private var selectedButton: UIButton?
    
    private var correctOption: Option {
        return options.filter({$0.isRight}).first!
    }
    
    private var timer: Timer?
    
    // MARK: - UI Elements
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Constants.purple
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = "10s"
        return label
    }()
    
    private let cardSongView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsCardView(view)
        return view
    }()
    
    private let cardSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let cardView = CardView()
    
    private let firstOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonFirstOption), for: .touchUpInside)
        return button
    }()
    
    private let firstOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonSecondOption), for: .touchUpInside)
        return button
    }()
    
    private let secondOptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let thirdOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonThirdOption), for: .touchUpInside)
        return button
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
        button.setTitle("Conferma", for: .normal)
        button.addTarget(self, action: #selector(buttonContinue), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.background
        
        view.addSubview(timerLabel)
        
        view.addSubview(cardSongView)
        cardSongView.addSubview(cardSongLabel)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        cardSongLabel.text = line
        
        options = [
            Option(button: firstOptionButton, label: firstOptionLabel, isRight: false),
            Option(button: secondOptionButton, label: secondOptionLabel, isRight: false),
            Option(button: thirdOptionButton, label: thirdOptionLabel, isRight: false)
        ]
        
        options.shuffle()
        
        let twoRandomArtists = Utility.artists.choose(2)
        
        options[0].label.text = track.artist_name
        options[0].isRight = true
        print("Right answer: \(track.artist_name)")
        
        options[1].label.text = twoRandomArtists.first?.artist_name
        options[2].label.text = twoRandomArtists.last?.artist_name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var counter = 10
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            [weak self] timer in
            counter -= 1
            
            self?.timerLabel.text = String(counter) + "s"
            if counter == 0 {
                timer.invalidate()
            }
        }
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        
        constraints.append(timerLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(timerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(cardSongView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(cardSongView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(cardSongView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(cardSongView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(cardSongLabel.leadingAnchor.constraint(equalTo: cardSongView.leadingAnchor, constant: Constants.padding))
        constraints.append(cardSongLabel.trailingAnchor.constraint(equalTo: cardSongView.trailingAnchor, constant: -Constants.padding))
        constraints.append(cardSongLabel.topAnchor.constraint(equalTo: cardSongView.topAnchor, constant: 10))
        constraints.append(cardSongLabel.bottomAnchor.constraint(equalTo: cardSongView.bottomAnchor, constant: -10))
        
        constraints.append(cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(cardView.topAnchor.constraint(equalTo: cardSongView.bottomAnchor, constant: Constants.padding))
        constraints.append(cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(firstOptionButton.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.padding))
        constraints.append(firstOptionButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.padding))
        constraints.append(firstOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(firstOptionLabel.centerYAnchor.constraint(equalTo: firstOptionButton.centerYAnchor))
        constraints.append(firstOptionLabel.leadingAnchor.constraint(equalTo: firstOptionButton.leadingAnchor, constant: Constants.padding))
        constraints.append(firstOptionLabel.trailingAnchor.constraint(equalTo: firstOptionButton.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(secondOptionButton.topAnchor.constraint(equalTo: firstOptionButton.bottomAnchor, constant: 10))
        constraints.append(secondOptionButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.padding))
        constraints.append(secondOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(secondOptionLabel.centerYAnchor.constraint(equalTo: secondOptionButton.centerYAnchor))
        constraints.append(secondOptionLabel.leadingAnchor.constraint(equalTo: secondOptionButton.leadingAnchor, constant: Constants.padding))
        constraints.append(secondOptionLabel.trailingAnchor.constraint(equalTo: secondOptionButton.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(thirdOptionButton.topAnchor.constraint(equalTo: secondOptionButton.bottomAnchor, constant: 10))
        constraints.append(thirdOptionButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.padding))
        constraints.append(thirdOptionButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Constants.padding))
        constraints.append(thirdOptionButton.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(thirdOptionLabel.centerYAnchor.constraint(equalTo: thirdOptionButton.centerYAnchor))
        constraints.append(thirdOptionLabel.leadingAnchor.constraint(equalTo: thirdOptionButton.leadingAnchor, constant: Constants.padding))
        constraints.append(thirdOptionLabel.trailingAnchor.constraint(equalTo: thirdOptionButton.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(continueButton.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: Constants.padding))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(continueButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    private func styleButtonAsSelected(_ button: UIButton, _ label: UILabel, selected: Bool) {
        if selected {
            UIUtility.styleAsOptionButtonSelected(button)
            label.textColor = .white
        } else {
            UIUtility.styleAsOptionButton(button)
            label.textColor = .black
        }
    }
    
    private func styleButtonAsCorrect(_ button: UIButton, correct: Bool) {
        if correct {
            button.backgroundColor = .green
        } else {
            button.backgroundColor = .red
        }
        
        for subview in button.subviews {
            if let label = subview as? UILabel {
                label.textColor = .white
            }
        }
    }
    
    private func enableButtonIfNeeded() {
        if !continueButton.isEnabled {
            continueButton.isEnabled = true
            continueButton.isUserInteractionEnabled = true
            continueButton.alpha = 1
        }
    }
    
    private func checkCorrectAnswer() -> Bool {
        guard let selectedButton = selectedButton else {
            return false
        }
        
        timer?.invalidate()
        
        if selectedButton == correctOption.button {
            // Correct answer
            styleButtonAsCorrect(selectedButton, correct: true)
            return true
        } else {
            // Wrong answer
            styleButtonAsCorrect(selectedButton, correct: false)
            styleButtonAsCorrect(correctOption.button, correct: true)
            
            return false
        }
    }
    
    
    // MARK: - Actions
    
    @objc func buttonContinue() {
        let correctResult = checkCorrectAnswer()
        
        if correctResult {
            // Increase current score
            Utility.currentScore += Constants.pointsPerCorrectAnswer
            
            self.dismiss(animated: true) {
                self.delegate?.didRepeatGame(self)
            }
        } else {
            // Save total score
            let totalScore = Score(points: Utility.currentScore, date: Date())
            UserUtility.connectedUser?.scoreList.append(totalScore)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                UIUtility.showSimpleAlert(title: "Hai perso!", message: "Vai al tuo risultato!", button: "Vai!", controller: self) {
                    self.dismiss(animated: true) {
                        self.delegate?.didEndGame(self)
                    }
                }
            }
        }
    }
    
    @objc func buttonFirstOption() {
        enableButtonIfNeeded()
        
        selectedButton = firstOptionButton
        styleButtonAsSelected(firstOptionButton, firstOptionLabel, selected: true)
        styleButtonAsSelected(secondOptionButton, secondOptionLabel, selected: false)
        styleButtonAsSelected(thirdOptionButton, thirdOptionLabel, selected: false)
    }
    
    @objc func buttonSecondOption() {
        enableButtonIfNeeded()
        
        selectedButton = secondOptionButton
        styleButtonAsSelected(firstOptionButton, firstOptionLabel, selected: false)
        styleButtonAsSelected(secondOptionButton, secondOptionLabel, selected: true)
        styleButtonAsSelected(thirdOptionButton, thirdOptionLabel, selected: false)
    }
    
    @objc func buttonThirdOption() {
        enableButtonIfNeeded()
        
        selectedButton = thirdOptionButton
        styleButtonAsSelected(firstOptionButton, firstOptionLabel, selected: false)
        styleButtonAsSelected(secondOptionButton, secondOptionLabel, selected: false)
        styleButtonAsSelected(thirdOptionButton, thirdOptionLabel, selected: true)
    }
}

protocol QuizControllerDelegate: NSObjectProtocol {
    
    func didEndGame(_ sender: QuizController)
    func didRepeatGame(_ sender: QuizController)
}
