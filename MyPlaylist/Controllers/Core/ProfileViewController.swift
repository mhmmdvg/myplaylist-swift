//
//  ProfileViewController.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

class ProfileViewController: UIViewController {

    private let imageProfile: UIImageView = {
        let imageProfile = UIImageView()
        let radius = imageProfile.frame.width / 2
        imageProfile.translatesAutoresizingMaskIntoConstraints = false
        
        return imageProfile
    }()
    
    private let signOutButton: UIButton = {
        let signOutButton = UIButton()
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        signOutButton.backgroundColor = .systemGray4
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        signOutButton.setTitleColor(.white, for: .normal)

        return signOutButton
    }()
    
    private let nameText: UILabel = {
        let nameText = UILabel()
        
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.textColor = .black
        nameText.font = UIFont.boldSystemFont(ofSize: 20)
        
        return nameText
    }()
    
    private let idText: UILabel = {
        let idText = UILabel()
        
        idText.translatesAutoresizingMaskIntoConstraints = false
        idText.font = UIFont.boldSystemFont(ofSize: 20)
        
        
        return idText
    }()
    
    private let myWeb: UILabel = {
        let myWeb = UILabel()
        
        myWeb.translatesAutoresizingMaskIntoConstraints = false
        myWeb.text = "https://mhmmdvg.vercel.app"
        myWeb.textColor = .systemPink
        myWeb.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        
        return myWeb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(imageProfile)
        view.addSubview(nameText)
        view.addSubview(idText)
        view.addSubview(myWeb)
        view.addSubview(signOutButton)
        
        fetchProfile()
        
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(imageProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(imageProfile.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageProfile.widthAnchor.constraint(equalToConstant: 150))
        constraints.append(imageProfile.heightAnchor.constraint(equalToConstant: 150))
        
        constraints.append(nameText.topAnchor.constraint(greaterThanOrEqualTo: imageProfile.safeAreaLayoutGuide.topAnchor, constant: 160))
        constraints.append(nameText.centerXAnchor.constraint(equalTo: imageProfile.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(idText.bottomAnchor.constraint(greaterThanOrEqualTo: imageProfile.safeAreaLayoutGuide.bottomAnchor, constant: 30))
        constraints.append(idText.centerXAnchor.constraint(equalTo: imageProfile.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(myWeb.bottomAnchor.constraint(greaterThanOrEqualTo: idText.safeAreaLayoutGuide.bottomAnchor, constant: 30))
        constraints.append(myWeb.centerXAnchor.constraint(equalTo: idText.safeAreaLayoutGuide.centerXAnchor))
        
        constraints.append(signOutButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(signOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(signOutButton.widthAnchor.constraint(equalToConstant: view.frame.size.width))
        constraints.append(signOutButton.heightAnchor.constraint(equalToConstant: 50))

        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func fetchProfile() {
        APICaller.shared.getCurrentProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedGetProfile()
                }
            }
        }
    }
    
    private func updateUI(with model: UserProfile) {
        guard let urlString = model.images.first?.url, let url = URL(string: urlString) else {
            return
        }
        self.navigationItem.title = (model.display_name)
        idText.text = "@\(model.id)"
        
        imageProfile.layer.masksToBounds = true
        imageProfile.clipsToBounds = true
        imageProfile.layer.cornerRadius = imageProfile.frame.size.width / 2
        imageProfile.contentMode = .scaleAspectFill
        imageProfile.load(url: url)
    }
        
    private func failedGetProfile() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load Profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    
    @objc func signOut() {
        AuthService.shared.signOutAction { [weak self] signedOut in
            if signedOut {
                DispatchQueue.main.async {
                    let signInVC = UINavigationController(rootViewController: SignInViewController())
                    signInVC.modalPresentationStyle = .fullScreen
                    
                    self?.present(signInVC, animated: true, completion: {
                        self?.navigationController?.popToRootViewController(animated: true)
                    })
                    
                }
            }
        }
    }
    

}
