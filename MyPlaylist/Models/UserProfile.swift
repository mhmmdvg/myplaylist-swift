//
//  UserProfile.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import Foundation

struct UserProfile: Codable {
    let display_name: String
    let id: String
    let images: [UserImage]
}


struct UserImage: Codable {
    let url: String
}
