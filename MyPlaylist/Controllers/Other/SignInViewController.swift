//
//  SignInViewController.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let signInButton = UIButton()
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.backgroundColor = .systemGreen
        signInButton.setTitle("Sign In with Spotify", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = 8
        return signInButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Playlist"
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        view.addSubview(signInButton)
        
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signInButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
    }
    
    @objc func signIn() {
        let auth = AuthViewController()
        auth.completion = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        auth.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(auth, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when sign in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBar = TabBarViewController()
        mainAppTabBar.modalPresentationStyle = .fullScreen
        present(mainAppTabBar, animated: true)
    }

}
