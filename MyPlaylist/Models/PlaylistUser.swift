//
//  PlaylistUser.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 04/09/22.
//

import Foundation

struct PlaylistUserItem: Codable {
    let items: [PlaylistUser]
}

struct PlaylistUser: Codable {
    let name: String
    let id: String
    let type: String
    let owner: Owner
    let description: String
    let images: [PlaylistImages]
    let tracks: TracksTotal
}

struct TracksTotal: Codable {
    let total: Int
}

struct Owner: Codable {
    let display_name: String
}

struct PlaylistImages: Codable {
    let url: String
}
