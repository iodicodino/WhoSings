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
    
    private let timerLabel: CustomLabel = {
        let label = CustomLabel()
        label.textColor = Constants.purple
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.text = "\(Constants.timePerQuestion)s"
        return label
    }()
    
    private let cardSongView = CardView()
    
    private let cardSongLabel: CustomLabel = {
        let label = CustomLabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let stackCardView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 10
        view.distribution = .fillEqually
        view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        view.isLayoutMarginsRelativeArrangement = true
        UIUtility.styleAsCardView(view)
        return view
    }()
    
    private let firstOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonFirstOption), for: .touchUpInside)
        return button
    }()
    
    private let firstOptionLabel = CustomLabel()
    
    private let secondOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonSecondOption), for: .touchUpInside)
        return button
    }()
    
    private let secondOptionLabel = CustomLabel()
    
    private let thirdOptionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsOptionButton(button)
        button.addTarget(self, action: #selector(buttonThirdOption), for: .touchUpInside)
        return button
    }()
    
    private let thirdOptionLabel = CustomLabel()
    
    private let continueButton: SalmonButton = {
        let button = SalmonButton()
        button.setTitle("title.confirm".localized, for: .normal)
        button.addTarget(self, action: #selector(buttonContinue), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.background
        
        // Subviews
        view.addSubview(timerLabel)
        
        view.addSubview(cardSongView)
        cardSongView.addSubview(cardSongLabel)
        
        view.addSubview(stackCardView)
        
        stackCardView.addArrangedSubview(firstOptionButton)
        firstOptionButton.addSubview(firstOptionLabel)
        
        stackCardView.addArrangedSubview(secondOptionButton)
        secondOptionButton.addSubview(secondOptionLabel)
        
        stackCardView.addArrangedSubview(thirdOptionButton)
        thirdOptionButton.addSubview(thirdOptionLabel)
        
        view.addSubview(continueButton)
        
        // Notification Center
        NotificationCenter.default.addObserver(self, selector: #selector(adaptToRotation), name: UIDevice.orientationDidChangeNotification, object: nil)

        /// Button
        continueButton.isEnabled = false
        continueButton.isUserInteractionEnabled = false
        continueButton.alpha = 0.5
        
        addConstraints()
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cardSongLabel.text = line
        
        options = [
            Option(button: firstOptionButton, label: firstOptionLabel, isRight: false),
            Option(button: secondOptionButton, label: secondOptionLabel, isRight: false),
            Option(button: thirdOptionButton, label: thirdOptionLabel, isRight: false)
        ]
        
        options.shuffle()
        
        let twoRandomArtists = Utility.filteredArtists(number: 2, withoutId: track.artist_id)
        
        options[0].label.text = track.artist_name
        options[0].isRight = true
        print("Right answer: \(track.artist_name)")
        
        options[1].label.text = twoRandomArtists.first?.artist_name
        options[2].label.text = twoRandomArtists.last?.artist_name
        
        // Rotation
        adaptToRotation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var counter = Constants.timePerQuestion
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            [weak self] timer in
            counter -= 1
            
            self?.timerLabel.text = String(counter) + "s"
            if counter == 0 {
                timer.invalidate()
                
                self?.buttonContinue()
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
        
        constraints.append(stackCardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(stackCardView.topAnchor.constraint(equalTo: cardSongView.bottomAnchor, constant: Constants.padding))
        constraints.append(stackCardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(stackCardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(firstOptionLabel.topAnchor.constraint(equalTo: firstOptionButton.topAnchor, constant: 15))
        constraints.append(firstOptionLabel.bottomAnchor.constraint(equalTo: firstOptionButton.bottomAnchor, constant: -15))
        constraints.append(firstOptionLabel.leadingAnchor.constraint(equalTo: firstOptionButton.leadingAnchor, constant: 15))
        constraints.append(firstOptionLabel.trailingAnchor.constraint(equalTo: firstOptionButton.trailingAnchor, constant: -15))
        
        constraints.append(secondOptionLabel.topAnchor.constraint(equalTo: secondOptionButton.topAnchor, constant: 15))
        constraints.append(secondOptionLabel.bottomAnchor.constraint(equalTo: secondOptionButton.bottomAnchor, constant: -15))
        constraints.append(secondOptionLabel.leadingAnchor.constraint(equalTo: secondOptionButton.leadingAnchor, constant: 15))
        constraints.append(secondOptionLabel.trailingAnchor.constraint(equalTo: secondOptionButton.trailingAnchor, constant: -15))
        
        constraints.append(thirdOptionLabel.topAnchor.constraint(equalTo: thirdOptionButton.topAnchor, constant: 15))
        constraints.append(thirdOptionLabel.bottomAnchor.constraint(equalTo: thirdOptionButton.bottomAnchor, constant: -15))
        constraints.append(thirdOptionLabel.leadingAnchor.constraint(equalTo: thirdOptionButton.leadingAnchor, constant: 15))
        constraints.append(thirdOptionLabel.trailingAnchor.constraint(equalTo: thirdOptionButton.trailingAnchor, constant: -15))
        
        constraints.append(continueButton.topAnchor.constraint(equalTo: stackCardView.bottomAnchor, constant: Constants.padding))
        constraints.append(continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(continueButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(continueButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Private functions
    
    @objc func adaptToRotation() {
        let orientation = UIDevice.current.orientation
        
        switch orientation {
        case .portrait:
            fallthrough
        case .portraitUpsideDown:
            stackCardView.axis = .vertical
        case .landscapeLeft:
            fallthrough
        case .landscapeRight:
            stackCardView.axis = .horizontal
        case .faceUp:
            fallthrough
        case .faceDown:
            fallthrough
        case .unknown:
            fallthrough
        @unknown default:
            if view.frame.width > view.frame.height {
                // Landscape
                stackCardView.axis = .horizontal
            } else {
                // Portrait
                stackCardView.axis = .vertical
            }
        }
        
        view.layoutIfNeeded()
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
            // No selected button, time ended up
            styleButtonAsCorrect(correctOption.button, correct: true)
            // Reveal all the options
            let wrongOptions = options.filter({!$0.isRight})
            styleButtonAsCorrect(wrongOptions.first!.button, correct: false)
            styleButtonAsCorrect(wrongOptions.last!.button, correct: false)
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
            Utility.currentScore = 0 // Reset current score
            UserUtility.connectedUser?.scoreList.append(totalScore)
            UserUtility.updateConnectedUser()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIUtility.showSimpleAlert(title: "alert.title.gameLost", message: "alert.message.gameLost", button: "alert.button.gameLost", controller: self) {
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
