//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit
import MBProgressHUD


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let progressHUD = MBProgressHUD(view: view)
        
        if Constants.connectedUser == nil {
            let next = LoginController()
            next.modalPresentationStyle = .fullScreen
            present(next, animated: true, completion: nil)
        } else {
            
            //progressHUD.show(animated: true)
            
            NetworkUtility.requestArtists {
                [weak self] artists in
                
                if let artists = artists {
                    Utility.artists = artists
                    
                    NetworkUtility.requestRandomTrackWithRandomLine {
                        [weak self] track, line in
                        
                        let next = QuizController()
                        next.line = line
                        next.track = track
                        
                        let navigation = UINavigationController(rootViewController: next)
                        navigation.modalPresentationStyle = .fullScreen
                        self?.present(navigation, animated: true)
                        
                    }
                }
            }
        }
    }
    
}
