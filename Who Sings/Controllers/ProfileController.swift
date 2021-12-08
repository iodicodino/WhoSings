//
//  ProfileController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var delegate: ProfileControllerDelegate?
    
    private var dataSource: [Score] = []
    
    
    // MARK: - UI Elements
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.profileImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let usernameLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = UserUtility.connectedUser?.name
        return label
    }()
    
    private let containerLastScore = CustomView()
    
    private let lastScoreTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "profileController.label.lastScore".localized
        return label
    }()
    
    private let lastScoreLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Constants.salmon
        label.text = UserUtility.connectedUser?.scoreList.last?.pointsString ?? "0 pt"
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    private let playAgainButton: SalmonButton = {
        let button = SalmonButton()
        button.setTitle("profileController.button.playAgain".localized, for: .normal)
        button.addTarget(self, action: #selector(buttonPlayAgain), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Constants.background
        
        // Navigation
        
        let leftButton =  UIBarButtonItem(image: Constants.exitImage, style: .plain, target: self, action: #selector(didTapOnExitButton))
        navigationItem.setLeftBarButton(leftButton, animated: true)
        
        let rightButton =  UIBarButtonItem(image: Constants.crownImage, style: .plain, target: self, action: #selector(didTapOnChartButton))
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        // Subviews
        view.addSubview(imageView)
        view.addSubview(usernameLabel)
        view.addSubview(containerLastScore)
        containerLastScore.addSubview(lastScoreTitle)
        containerLastScore.addSubview(lastScoreLabel)
        view.addSubview(tableView)
        view.addSubview(playAgainButton)
        addConstraints()
        
        // DataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        dataSource = UserUtility.connectedUser?.scoreList.reversed() ?? []
        
        tableView.reloadData()
    }


    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding))
        constraints.append(usernameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(usernameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(containerLastScore.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10))
        constraints.append(containerLastScore.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(containerLastScore.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(lastScoreTitle.topAnchor.constraint(equalTo: containerLastScore.topAnchor, constant: 10))
        constraints.append(lastScoreTitle.bottomAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: 10))
        constraints.append(lastScoreTitle.leadingAnchor.constraint(equalTo: containerLastScore.leadingAnchor, constant: 10))
        constraints.append(lastScoreLabel.topAnchor.constraint(equalTo: containerLastScore.topAnchor, constant: 10))
        constraints.append(lastScoreLabel.bottomAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: 10))
        constraints.append(lastScoreLabel.leadingAnchor.constraint(equalTo: lastScoreTitle.trailingAnchor, constant: 10))
        constraints.append(lastScoreLabel.trailingAnchor.constraint(equalTo: containerLastScore.trailingAnchor, constant: -10))
        constraints.append(lastScoreLabel.widthAnchor.constraint(equalTo: lastScoreTitle.widthAnchor))
        
        constraints.append(tableView.topAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: Constants.padding))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(playAgainButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.padding))
        constraints.append(playAgainButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(playAgainButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(playAgainButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        constraints.append(playAgainButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileCell()
        cell.selectionStyle = .none
        cell.awakeFromNib()
        
        let currentScore = dataSource[indexPath.row]
        cell.setupWithScore(currentScore)
        
        return cell
    }
    
    // MARK: - Actions
    
    @objc func didTapOnExitButton() {
        UIUtility.showConfirmationAlert(title: "alert.title.logout", message: "alert.message.logout", buttonOk: "title.yes", buttonClose: "title.no", controller: self) {
            UserUtility.disconnectCurrentUser()
            
            self.dismiss(animated: true) {
                self.delegate?.didTapOnExitButton(self)
            }
        }
    }
    
    @objc func didTapOnChartButton() {
        let next = ScoreChartController()
        present(next, animated: true, completion: nil)
    }
    
    @objc func buttonPlayAgain() {
        self.dismiss(animated: true) {
            self.delegate?.didTapOnPlayAgain(self)
        }
    }
}

protocol ProfileControllerDelegate : NSObjectProtocol {
    
    func didTapOnExitButton(_ sender: ProfileController)
    func didTapOnPlayAgain(_ sender: ProfileController)
}
