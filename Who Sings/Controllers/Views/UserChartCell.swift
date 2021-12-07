//
//  UserChartCell.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 07/12/21.
//

import Foundation
import UIKit

class UserChartCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    var cardView = CardView()
    var positionContainer = UIView()
    var labelPosition = CustomLabel()
    var labelName = CustomLabel()
    var labelScore = CustomLabel()
    
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupLabels()
        setupViews()
        
        contentView.addSubview(cardView)
        cardView.addSubview(positionContainer)
        positionContainer.addSubview(labelPosition)
        cardView.addSubview(labelScore)
        cardView.addSubview(labelName)
        
        addConstraints()
    }
    
    private func setupLabels() {
        labelPosition.textAlignment = .center
        labelScore.textAlignment = .center
        labelName.textAlignment = .center
    }
    
    private func setupViews() {
        UIUtility.addCircularCornerRadius(positionContainer)
        UIUtility.addBorder(positionContainer, withColor: Constants.purple, width: 2)
    }
    
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(cardView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5))
        constraints.append(cardView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5))
        constraints.append(cardView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5))
        constraints.append(cardView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5))
        constraints.append(cardView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(positionContainer.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5))
        constraints.append(positionContainer.centerYAnchor.constraint(equalTo: cardView.centerYAnchor))
        constraints.append(positionContainer.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 5))
        constraints.append(positionContainer.heightAnchor.constraint(equalToConstant: 20))
                           
        constraints.append(labelPosition.centerYAnchor.constraint(equalTo: positionContainer.centerYAnchor))
        constraints.append(labelPosition.centerXAnchor.constraint(equalTo: positionContainer.centerXAnchor))
        
        constraints.append(labelName.centerYAnchor.constraint(equalTo: cardView.centerYAnchor))
        constraints.append(labelName.leadingAnchor.constraint(equalTo: positionContainer.leadingAnchor, constant: 5))
        constraints.append(labelScore.centerYAnchor.constraint(equalTo: cardView.centerYAnchor))
        constraints.append(labelScore.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 5))
        constraints.append(labelScore.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5))
        constraints.append(labelScore.widthAnchor.constraint(equalTo: labelName.widthAnchor))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    public func setupWithUser(_ user: User, position: Int) {
        
        labelName.text = user.name
        labelScore.text = user.bestScore?.pointsString
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelScore.font = UIFont.systemFont(ofSize: 12)
        labelScore.textColor = .black
        labelName.textColor = .black
        
        labelPosition.text = String(position)
    }
}
