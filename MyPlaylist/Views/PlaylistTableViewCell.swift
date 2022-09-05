//
//  PlaylistTableViewCell.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {
    
    private let playlistImage: UIImageView = {
        let playlistImage = UIImageView()
        playlistImage.translatesAutoresizingMaskIntoConstraints = false
        playlistImage.layer.cornerRadius = 4
        playlistImage.clipsToBounds = true
        playlistImage.layer.masksToBounds = true
        
        playlistImage.image = UIImage(systemName: "music.note")
        return playlistImage
    }()
    
    private let playlistName: UILabel = {
        let playlistName = UILabel()
        playlistName.translatesAutoresizingMaskIntoConstraints = false
        return playlistName
    }()
    
    private let typeTitle: UILabel = {
       let typeTitle = UILabel()
        typeTitle.translatesAutoresizingMaskIntoConstraints = false
        typeTitle.textColor = .systemGray
        typeTitle.font = UIFont.systemFont(ofSize: 16)
        

        return typeTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(playlistImage)
        addSubview(playlistName)
        addSubview(typeTitle)
        
        
        addConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: PlaylistUser) {
        guard let urlString = data.images.first?.url, let url = URL(string: urlString) else {
            return
        }
        playlistImage.load(url: url)
        playlistName.text = data.name
        typeTitle.text = "\(data.type) • \(data.owner.display_name)"
        
        
    }
    
    private func addConstrainst() {
        var constraints = [NSLayoutConstraint]()
        
        
        constraints.append(playlistImage.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(playlistImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 12))
        constraints.append(playlistImage.heightAnchor.constraint(equalToConstant: 65))
        constraints.append(playlistImage.widthAnchor.constraint(equalToConstant: 65))
        
        constraints.append(playlistName.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 8))
        constraints.append(playlistName.leadingAnchor.constraint(equalTo: playlistImage.safeAreaLayoutGuide.trailingAnchor, constant: 10))
        constraints.append(playlistName.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(playlistName.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -12))
        
        constraints.append(typeTitle.topAnchor.constraint(greaterThanOrEqualTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 32))
        constraints.append(typeTitle.leadingAnchor.constraint(equalTo: playlistImage.safeAreaLayoutGuide.trailingAnchor, constant: 10))
        constraints.append(typeTitle.heightAnchor.constraint(equalTo: playlistName.heightAnchor))
        
        
        NSLayoutConstraint.activate(constraints)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
