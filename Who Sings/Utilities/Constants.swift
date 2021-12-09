//
//  Constants.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 02/12/21.
//

import Foundation
import UIKit

class Constants {
    
    // MARK: - General
    
    static var pointsPerCorrectAnswer: Int { return 10 }
    static var timePerQuestion: Int { return 15 }
    
    // MARK: - User defaults
    
    static var connectedUserDefaults: String { return "connectedUser" }
    static var storedUsersDefaults: String { return "storedUsers" }
    
    // MARK: - UI
    
    static var padding: CGFloat { return 30 }
    static var buttonHeight: CGFloat { return 50 }
    static var buttonCornerRadius: CGFloat { return 8 }
    static var inset: CGFloat { return 10 }
    
    
    // MARK: - Colors
    
    static var salmon: UIColor { return UIColor(rgb: 0xd982ae) }
    static var background: UIColor { return UIColor(rgb: 0xf8fafb) }
    static var border: UIColor { return UIColor(rgb: 0xeeeeee) }
    static var purple: UIColor { return UIColor(rgb: 0x6574ea) }
    static var green: UIColor { return UIColor(rgb: 0x3cd4b2)}
    static var red: UIColor { return UIColor(rgb: 0xc3406f)}
    
    
    // MARK: - Images
    
    static var questionMarkImage = UIImage(named: "question-mark")
    static var profileImage = UIImage(named: "brain")
    static var scoreChartImage = UIImage(named: "podium")
    static var exitImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
    static var crownImage = UIImage(systemName: "crown")
    static var closeImage = UIImage(systemName: "xmark")
}
