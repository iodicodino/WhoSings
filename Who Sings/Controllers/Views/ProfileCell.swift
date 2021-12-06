//
//  ProfileCell.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    var cardView = CardView()
    var labelScore = CustomLabel()
    var labelDate = CustomLabel()
    
    
    // MARK: - Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.addSubview(cardView)
        cardView.addSubview(labelDate)
        cardView.addSubview(labelScore)
        
        labelDate.textAlignment = .center
        labelScore.textAlignment = .center
        
        addConstraints()
    }
    
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        // Add
        constraints.append(cardView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 5))
        constraints.append(cardView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5))
        constraints.append(cardView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5))
        constraints.append(cardView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -5))
        constraints.append(cardView.heightAnchor.constraint(equalToConstant: 50))
        
        constraints.append(labelScore.centerYAnchor.constraint(equalTo: cardView.centerYAnchor))
        constraints.append(labelScore.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 5))
        constraints.append(labelDate.centerYAnchor.constraint(equalTo: cardView.centerYAnchor))
        constraints.append(labelDate.leadingAnchor.constraint(equalTo: labelScore.trailingAnchor, constant: 5))
        constraints.append(labelDate.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -5))
        constraints.append(labelDate.widthAnchor.constraint(equalTo: labelScore.widthAnchor))
        
        // Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    public func setupWithScore(_ score: Score) {
        
        labelScore.text = score.pointsString
        labelDate.text = score.dateString
        labelScore.font = UIFont.boldSystemFont(ofSize: 16)
        labelDate.font = UIFont.systemFont(ofSize: 12)
        labelDate.textColor = .black
        labelScore.textColor = .black
    }
    
    public func setupWithAsBestScore(_ score: Score) {
        
        labelScore.text = score.pointsString
        labelDate.text = score.dateString
        labelScore.font = UIFont.boldSystemFont(ofSize: 16)
        labelDate.font = UIFont.systemFont(ofSize: 12)
        cardView.backgroundColor = .purple
        labelDate.textColor = .white
        labelScore.textColor = .white
    }
}
