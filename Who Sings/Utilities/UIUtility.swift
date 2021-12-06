//
//  UIUtility.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit


class UIUtility {
    
    // MARK: - General
    
    static func styleAsCardView(_ view: UIView?) {
        UIUtility.addContainerShadow(view)
        UIUtility.addCornerRadius(view, withRadius: 24)
        view?.backgroundColor = .white
    }
    
    static func styleAsSalmonButton(_ button: UIButton?) {
        button?.backgroundColor = Constants.salmon
        button?.setTitleColor(.white, for: .normal)
        button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        UIUtility.addCornerRadius(button, withRadius: Constants.buttonCornerRadius)
    }
    
    static func styleAsOptionButton(_ button: UIButton?) {
        button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        UIUtility.addCornerRadius(button, withRadius: 25)
        UIUtility.addBorder(button, withColor: Constants.border, width: 2)
        button?.backgroundColor = Constants.background
        button?.setTitleColor(.black, for: .normal)
    }
    
    static func styleAsOptionButtonSelected(_ button: UIButton?) {
        button?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        UIUtility.addCornerRadius(button, withRadius: 25)
        UIUtility.addBorder(button, withColor: Constants.border, width: 2)
        button?.backgroundColor = Constants.purple
        button?.setTitleColor(.white, for: .normal)
    }
    
    static func addBorder(_ view: UIView?, withColor color: UIColor?, width: CGFloat) {
        if let color = color {
            view?.layer.borderColor = color.cgColor
            view?.layer.borderWidth = width
        }
    }
    
    static func addDefaultBorder(_ view: UIView?) {
        let borderColor = Constants.border
        addBorder(view, withColor: borderColor, width: 1.0)
    }
    
    static func removeBorder(_ view: UIView?) {
        view?.layer.borderWidth = 0.0
    }
    
    static func addCornerRadius(_ view: UIView?, withRadius radius: CGFloat) {
        view?.layer.cornerRadius = radius
    }
    
    static func addCircularCornerRadius(_ view: UIView?) {
        if let view = view {
            view.layer.cornerRadius = view.frame.size.height / 2.0
        }
    }
    
    static func removeCornerRadius(_ view: UIView?) {
        view?.layer.cornerRadius = 0.0
    }
    
    static func addShadow(_ view: UIView?, withColor color: UIColor?, radius: CGFloat, offset: CGSize) {
        if let color = color {
            view?.layer.masksToBounds = false
            view?.layer.shadowColor = color.cgColor
            view?.layer.shadowOffset = offset
            view?.layer.shadowRadius = radius
            view?.layer.shadowOpacity = 1.0
        }
    }
    
    static func addContainerShadow(_ view: UIView?) {
        let shadowColor = UIColor.black.withAlphaComponent(0.14)
        let shadowRadius = 10 as CGFloat
        let shadowOffset = CGSize.zero
        
        addShadow(view, withColor: shadowColor, radius: shadowRadius, offset: shadowOffset)
        
        view?.superview?.layer.masksToBounds = false
    }
    
    static func removeShadow(_ view: UIView?) {
        view?.layer.shadowOpacity = 0.0
    }
    
    
    // MARK: - Alerts
    
    static func showSimpleAlert(title: String, message: String, button: String, controller: UIViewController, completion: EmptyCompletion?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.cancel, handler: { action in
            completion?()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
