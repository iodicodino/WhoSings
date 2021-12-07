//
//  ScoreChartController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 07/12/21.
//

import Foundation
import UIKit

class ScoreChartController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var dataSource: [User] = []
    
    
    // MARK: - UI Elements
    
    private let imageView: UIImageView = {
        let view = UIImageView(image: Constants.scoreChartImage)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = CustomLabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "La classifica di Who Sings!"
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = CustomLabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "Ecco i giocatori che hanno effettuato un maggior punteggio"
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
        
        view.backgroundColor = Constants.background
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(messageLabel)
        view.addSubview(tableView)
        
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isUserInteractionEnabled = false
        
        addConstraints()
        
        setupDataSource()
    }


    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding))
        constraints.append(imageView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(imageView.trailingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(imageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25))
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
        
        constraints.append(tableView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: Constants.padding))
        constraints.append(tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.padding))
        constraints.append(tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constants.padding))
        constraints.append(tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Private functions
    
    private func setupDataSource() {
        dataSource = UserUtility.getUsersOrderedByBest()
        tableView.reloadData()
    }
    
    // MARK: - UITableView Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserChartCell()
        cell.awakeFromNib()
        
        let currentUser = dataSource[indexPath.row]
        cell.setupWithUser(currentUser, position: indexPath.row + 1)
        
        return cell
    }
}
