//
//  CustomLabel.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    public required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        numberOfLines = 0
    }
    
}
