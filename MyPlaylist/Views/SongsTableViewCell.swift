//
//  SongsTableViewCell.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 04/09/22.
//

import UIKit

class SongsTableViewCell: UITableViewCell {

    private let songImage: UIImageView = {
        let songImage = UIImageView()
        songImage.translatesAutoresizingMaskIntoConstraints = false
        songImage.layer.cornerRadius = 4
        songImage.clipsToBounds = true
        songImage.layer.masksToBounds = true
        
        songImage.image = UIImage(systemName: "music.note")
        return songImage
    }()
    
    private let songTitle: UILabel = {
        let songTitle = UILabel()
        songTitle.translatesAutoresizingMaskIntoConstraints = false
        return songTitle
    }()
    
    private let albumTitle: UILabel = {
       let albumTitle = UILabel()
        albumTitle.translatesAutoresizingMaskIntoConstraints = false
        albumTitle.textColor = .systemGray
        albumTitle.font = UIFont.systemFont(ofSize: 14)
        

        return albumTitle
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        contentView.backgroundColor = .systemBackground
    
    
        addSubview(songImage)
        addSubview(songTitle)
        addSubview(albumTitle)
        
        addConstrainst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(data: Playlist) {
        guard let urlString = data.track.album.images.first?.url, let url = URL(string: urlString) else {
            return
        }
        songImage.load(url: url)
        songTitle.text = data.track.name
        albumTitle.text = data.track.album.name
    }
    
    private func addConstrainst() {
        var constraints = [NSLayoutConstraint]()
        
        
        constraints.append(songImage.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(songImage.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 12))
        constraints.append(songImage.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(songImage.widthAnchor.constraint(equalToConstant: 50))
        
        constraints.append(songTitle.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: -5))
        constraints.append(songTitle.leadingAnchor.constraint(equalTo: songImage.safeAreaLayoutGuide.trailingAnchor, constant: 10))
        constraints.append(songTitle.heightAnchor.constraint(equalToConstant: 50))
        constraints.append(songTitle.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -12))
        
        constraints.append(albumTitle.topAnchor.constraint(greaterThanOrEqualTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16))
        constraints.append(albumTitle.leadingAnchor.constraint(equalTo: songImage.safeAreaLayoutGuide.trailingAnchor, constant: 10))
        constraints.append(albumTitle.heightAnchor.constraint(equalTo: songTitle.heightAnchor))
        
        
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
