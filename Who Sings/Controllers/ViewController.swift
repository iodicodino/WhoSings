//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit
import MBProgressHUD


class ViewController: UIViewController, LoginControllerDelegate, QuizControllerDelegate {
    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserUtility.connectedUser == nil {
            let next = LoginController()
            next.modalPresentationStyle = .fullScreen
            next.delegate = self
            present(next, animated: true, completion: nil)
        } else {
            let next = ProfileController()
            next.modalPresentationStyle = .fullScreen
            present(next, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Private functions
    
    private func requestArtistsIfNeeded(_ completion: @escaping () -> Void) {
        if Utility.artists.count == 0 {
            NetworkUtility.requestArtists {
                artists in
                
                if let artists = artists {
                    Utility.artists = artists
                    
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    private func startQuiz() {
        MBProgressHUD.showAdded(to: view, animated: true)
        
        requestArtistsIfNeeded() {
            NetworkUtility.requestRandomTrackWithRandomLine {
                [weak self] track, line in
                
                MBProgressHUD.hide(for: self!.view, animated: true)
                
                let next = QuizController()
                next.line = line
                next.track = track
                next.delegate = self
                next.modalPresentationStyle = .fullScreen
                self?.present(next, animated: true)
            }
        }
    }
    
    
    // MARK: - LoginController Delegate
    
    func didStartGame(_ sender: LoginController) {
        startQuiz()
    }
    
    
    // MARK: - QuizController Delegate
    
    func didEndGame(_ sender: QuizController) {
        let next = ProfileController()
        next.modalPresentationStyle = .fullScreen
        present(next, animated: true, completion: nil)
    }
    
    func didRepeatGame(_ sender: QuizController) {
        startQuiz()
    }
    
}
