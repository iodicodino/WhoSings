//
//  ViewController.swift
//  Who Sings
//
//  Created by Francesca Piccoli on 03/12/21.
//

import Foundation
import UIKit
import MBProgressHUD


class ViewController: UIViewController, LoginControllerDelegate, QuizControllerDelegate, ProfileControllerDelegate {
    
    private var isFirstSetup: Bool = false
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isFirstSetup = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // This code runs the first time only
        if isFirstSetup {
            isFirstSetup = false
            
            if UserUtility.connectedUser == nil {
                goToLogin()
            } else {
                goToProfile()
            }
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
            } errorCompletion: {
                self.showConnectionError()
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
            } errorCompletion: {
                self.showConnectionError()
            }
        }
    }
    
    private func goToLogin() {
        let next = LoginController()
        next.modalPresentationStyle = .fullScreen
        next.delegate = self
        present(next, animated: true, completion: nil)
    }
    
    private func goToProfile() {
        let next = ProfileController()
        next.delegate = self
        let navigation = UINavigationController(rootViewController: next)
        navigation.modalPresentationStyle = .fullScreen
        present(navigation, animated: true, completion: nil)
    }
    
    private func showConnectionError() {
        MBProgressHUD.hide(for: view, animated: true)
        
        UIUtility.showSimpleAlert(title: "alert.title.connectionError", message: "alert.message.connectionError", button: "title.ok", controller: self) {
            // Go back to previous screen
            if UserUtility.connectedUser == nil {
                self.goToLogin()
            } else {
                self.goToProfile()
            }
        }
    }
    
    // MARK: - LoginController Delegate
    
    func didStartGame(_ sender: LoginController) {
        startQuiz()
    }
    
    
    // MARK: - QuizController Delegate
    
    func didEndGame(_ sender: QuizController) {
        goToProfile()
    }
    
    func didRepeatGame(_ sender: QuizController) {
        startQuiz()
    }
    
    // MARK: - ProfileControllerDelegate
    
    func didTapOnExitButton(_ sender: ProfileController) {
        goToLogin()
    }
    
    func didTapOnPlayAgain(_ sender: ProfileController) {
        startQuiz()
    }
}
