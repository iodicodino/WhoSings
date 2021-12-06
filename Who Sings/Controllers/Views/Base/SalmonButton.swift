//
//  SalmonButton.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 06/12/21.
//

import Foundation
import UIKit

class SalmonButton: UIButton {
    
    public required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsSalmonButton(self)
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        UIUtility.styleAsSalmonButton(self)
    }
    
}
