//
//  TabBarViewController.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let playlist = PlaylistViewController()
        let profile = ProfileViewController()
        
        playlist.navigationItem.title = "My Songs"
        profile.title = "Profile"
        
        playlist.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        
        let navPlaylist = UINavigationController(rootViewController: playlist)
        let navProfile = UINavigationController(rootViewController: profile)
        
        navPlaylist.navigationBar.prefersLargeTitles = true
        navProfile.navigationBar.prefersLargeTitles = true
        
        navPlaylist.tabBarItem = UITabBarItem(title: "Playlist",
                                              image: UIImage(systemName: "music.note.list"),
                                              tag: 0)
        navProfile.tabBarItem = UITabBarItem(title: "Profile",
                                             image: UIImage(systemName: "person"),
                                             tag: 1)
        
        setViewControllers([navPlaylist, navProfile], animated: true)
    }
    



}
