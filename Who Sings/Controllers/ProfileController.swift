//
//  ProfileController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class ProfileController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        label.text = Constants.connectedUser?.name ?? "Provolone"
        return label
    }()
    
    private let containerLastScore = CustomView()
    
    private let lastScoreTitle: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "Ultimo punteggio:"
        return label
    }()
    
    private let lastScoreLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = String(Constants.connectedUser?.scoreList.last ?? 0)
        return label
    }()
    
    private let tableView = UITableView()
    
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
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.connectedUser?.scoreList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.ini
    }
}
