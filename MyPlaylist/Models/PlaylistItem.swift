//
//  Playlist.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import Foundation

struct PlaylistItems: Codable {
    let href: String
    let items: [Playlist]
}

struct Playlist: Codable {
    let is_local: Bool
    let added_by: AddedBy
    let track: Track
}

struct AddedBy: Codable {
   let id: String
}

struct Track: Codable {
    let artists: [Artist]
    let album: Album
    let name: String
    let duration_ms: Int
}

struct Album: Codable {
    let name: String
    let images: [Images]
    let release_date: String
}

struct Artist: Codable {
    let type: String
}

struct Images: Codable {
    let url: String
}
