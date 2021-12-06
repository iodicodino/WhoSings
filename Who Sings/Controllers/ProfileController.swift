//
//  ProfileController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var dataSource: [Score] = []
    
    
    // MARK: - UI Elements
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.profileImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        UIUtility.addCircularCornerRadius(view)
        UIUtility.addBorder(view, withColor: Constants.purple, width: 2)
        return view
    }()
    
    private let usernameLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = UserUtility.connectedUser?.name ?? "Provolone"
        return label
    }()
    
    private let containerLastScore = CustomView()
    
    private let lastScoreTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.text = "Ultimo punteggio:"
        return label
    }()
    
    private let lastScoreLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Constants.salmon
        label.text = UserUtility.connectedUser?.scoreList.last?.pointsString ?? "0pt"
        return label
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = Constants.background
        
        view.addSubview(imageView)
        view.addSubview(usernameLabel)
        view.addSubview(containerLastScore)
        containerLastScore.addSubview(lastScoreTitle)
        containerLastScore.addSubview(lastScoreLabel)
        view.addSubview(tableView)
        
        addConstraints()
        
        //dataSource = Constants.connectedUser?.scoreList ?? []
        
        let scores = [Score(points: 10, date: Date()),
                      Score(points: 9, date: Date()),
                      Score(points: 5, date: Date()),
                      Score(points: 7, date: Date()),
                      Score(points: 4, date: Date())]
        dataSource = scores
        
        tableView.reloadData()
    }


    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 50))
        
        constraints.append(usernameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10))
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
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileCell()
        cell.awakeFromNib()
        
        let currentScore = dataSource[indexPath.row]
        cell.setupWithScore(currentScore)
        
        return cell
    }
}
