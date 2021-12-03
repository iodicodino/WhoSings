//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Constants.connectedUser == nil {
            let next = LoginController()
            next.modalPresentationStyle = .fullScreen
            present(next, animated: true, completion: nil)
        } else {
            let next = QuizController()
            let navigation = UINavigationController(rootViewController: next)
            navigation.modalPresentationStyle = .fullScreen
            present(navigation, animated: true)
        }
    }
    
}
