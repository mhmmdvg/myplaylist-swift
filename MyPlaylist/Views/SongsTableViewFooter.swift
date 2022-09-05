//
//  SongsTableViewFooter.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 04/09/22.
//

import UIKit

class SongsTableViewFooter: UITableViewHeaderFooterView {

    static let identifier = "SongsFooter"
    
    
    private let total: UILabel = {
        let total = UILabel()
        total.translatesAutoresizingMaskIntoConstraints = false
        total.font = UIFont.systemFont(ofSize: 14)
        total.textColor = .systemGray
 
        
        return total
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubview(total)
        
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
        
        
 
        constraints.append(total.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor))
        constraints.append(total.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20))
        

        
        NSLayoutConstraint.activate(constraints)
    }
    
    func set(totalSongs: Int?){
        total.text = "\(totalSongs!) songs"

    }

}
