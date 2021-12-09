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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    let contentView = CustomView()
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.profileImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let usernameLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = UserUtility.connectedUser?.name
        return label
    }()
    
    private let containerLastScore = CustomView()
    private let containerBestScore = CustomView()
    
    private let lastScoreTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
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
    
    private let bestScoreTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "profileController.label.bestScore".localized
        return label
    }()
    
    private let bestScoreLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Constants.salmon
        label.text = UserUtility.connectedUser?.bestScore?.pointsString ?? "0 pt"
        return label
    }()
    
    private let labelTableViewTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "profileController.label.titleTableView".localized
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.isUserInteractionEnabled = false
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
        navigationItem.title = "title.profile".localized
        
        // Navigation
        
        let leftButton =  UIBarButtonItem(image: Constants.exitImage, style: .plain, target: self, action: #selector(didTapOnExitButton))
        navigationItem.setLeftBarButton(leftButton, animated: true)
        
        let rightButton =  UIBarButtonItem(image: Constants.crownImage, style: .plain, target: self, action: #selector(didTapOnChartButton))
        navigationItem.setRightBarButton(rightButton, animated: true)
        
        // Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(containerLastScore)
        contentView.addSubview(containerBestScore)
        containerLastScore.addSubview(lastScoreTitle)
        containerLastScore.addSubview(lastScoreLabel)
        containerBestScore.addSubview(bestScoreTitle)
        containerBestScore.addSubview(bestScoreLabel)
        contentView.addSubview(tableView)
        contentView.addSubview(playAgainButton)
        contentView.addSubview(labelTableViewTitle)
        addConstraints()
        
        // DataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        dataSource = UserUtility.connectedUser?.scoreList.reversed() ?? []
        tableView.heightAnchor.constraint(equalToConstant: CGFloat(dataSource.count * 60)).isActive = true
        
        tableView.reloadData()
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
        
        constraints.append(imageView.centerXAnchor.constraint(equalTo:contentView.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 100))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 100))
        
        constraints.append(usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding))
        constraints.append(usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(containerLastScore.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: Constants.inset))
        constraints.append(containerLastScore.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(containerLastScore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(containerBestScore.topAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: Constants.inset))
        constraints.append(containerBestScore.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(containerBestScore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(lastScoreTitle.topAnchor.constraint(equalTo: containerLastScore.topAnchor, constant: Constants.inset))
        constraints.append(lastScoreTitle.bottomAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: Constants.inset))
        constraints.append(lastScoreTitle.leadingAnchor.constraint(equalTo: containerLastScore.leadingAnchor, constant: Constants.inset))
        constraints.append(lastScoreLabel.topAnchor.constraint(equalTo: containerLastScore.topAnchor, constant: Constants.inset))
        constraints.append(lastScoreLabel.bottomAnchor.constraint(equalTo: containerLastScore.bottomAnchor, constant: Constants.inset))
        constraints.append(lastScoreLabel.leadingAnchor.constraint(equalTo: lastScoreTitle.trailingAnchor, constant: Constants.inset))
        constraints.append(lastScoreLabel.trailingAnchor.constraint(equalTo: containerLastScore.trailingAnchor, constant: -Constants.inset))
        constraints.append(lastScoreLabel.widthAnchor.constraint(equalTo: lastScoreTitle.widthAnchor))
        
        constraints.append(bestScoreTitle.topAnchor.constraint(equalTo: containerBestScore.topAnchor, constant: Constants.inset))
        constraints.append(bestScoreTitle.bottomAnchor.constraint(equalTo: containerBestScore.bottomAnchor, constant: Constants.inset))
        constraints.append(bestScoreTitle.leadingAnchor.constraint(equalTo: containerBestScore.leadingAnchor, constant: Constants.inset))
        constraints.append(bestScoreLabel.topAnchor.constraint(equalTo: containerBestScore.topAnchor, constant: Constants.inset))
        constraints.append(bestScoreLabel.bottomAnchor.constraint(equalTo: containerBestScore.bottomAnchor, constant: Constants.inset))
        constraints.append(bestScoreLabel.leadingAnchor.constraint(equalTo: bestScoreTitle.trailingAnchor, constant: Constants.inset))
        constraints.append(bestScoreLabel.trailingAnchor.constraint(equalTo: containerBestScore.trailingAnchor, constant: -Constants.inset))
        constraints.append(bestScoreLabel.widthAnchor.constraint(equalTo: bestScoreTitle.widthAnchor))
        
        constraints.append(playAgainButton.topAnchor.constraint(equalTo: containerBestScore.bottomAnchor, constant: 50))
        constraints.append(playAgainButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(playAgainButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        constraints.append(playAgainButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight))
        
        constraints.append(labelTableViewTitle.topAnchor.constraint(equalTo: playAgainButton.bottomAnchor, constant: Constants.padding))
        constraints.append(labelTableViewTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(labelTableViewTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        
        constraints.append(tableView.topAnchor.constraint(equalTo: labelTableViewTitle.bottomAnchor, constant: Constants.padding))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding))
        
        
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
