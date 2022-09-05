//
//  SongsTableViewHeader.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 04/09/22.
//

import UIKit

class SongsTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "SongsHeader"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        
        
        return imageView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return name
    }()
    
    private let owner: UILabel = {
        let owner = UILabel()
        owner.translatesAutoresizingMaskIntoConstraints = false
        owner.textColor = .systemPink
        owner.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return owner
    }()
    
    private let desc: UILabel = {
        let desc = UILabel()
        desc.translatesAutoresizingMaskIntoConstraints = false
        desc.textColor = .systemGray
        desc.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return desc
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(imageView)
        contentView.addSubview(name)
        contentView.addSubview(owner)
        contentView.addSubview(desc)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addConstraints()
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        
        constraints.append(imageView.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(imageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -30))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.height-60))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: contentView.safeAreaLayoutGuide.layoutFrame.size.width-140))
        
        
        constraints.append(name.centerXAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(name.bottomAnchor.constraint(equalTo: imageView.safeAreaLayoutGuide.bottomAnchor, constant: 35))
        
        constraints.append(owner.centerXAnchor.constraint(equalTo: name.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(owner.bottomAnchor.constraint(equalTo: name.safeAreaLayoutGuide.bottomAnchor, constant: 25))
        
        constraints.append(desc.centerXAnchor.constraint(equalTo: owner.safeAreaLayoutGuide.centerXAnchor))
        constraints.append(desc.bottomAnchor.constraint(equalTo: owner.safeAreaLayoutGuide.bottomAnchor, constant: 20))
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func set(image: String?, namePlaylist: String?, ownerName: String?, description: String?){
        guard let urlString = image, let url = URL(string: urlString) else {
            return
        }
        imageView.load(url: url)
        name.text = namePlaylist
        owner.text = ownerName
        desc.text = description
        
    }

}
