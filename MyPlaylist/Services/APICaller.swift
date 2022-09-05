//
//  APICaller.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let baseAPI = "https://api.spotify.com/v1"
    }
    
    enum MethodHTTP: String {
        case GET
        case POST
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    private init() {}
    
    public func getCurrentProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPI + "/me"),
            type: .GET) { baseRequest in
                let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(UserProfile.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    public func getPlaylistUser(completion: @escaping (Result<PlaylistUserItem, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPI + "/me/playlists"),
            type: .GET) { baseRequest in
                let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
//                        let result2 = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                        print(result2)
                        let result = try JSONDecoder().decode(PlaylistUserItem.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }

    
    public func getPlaylistSong(id: String, completion: @escaping (Result<PlaylistItems, Error>) -> Void) {
        createRequest(
            with: URL(string: Constants.baseAPI + "/playlists/\(id)/tracks"),
            type: .GET) { baseRequset in
                let task = URLSession.shared.dataTask(with: baseRequset) { data, _, error in
                    guard let data = data, error == nil else {
                        completion(.failure(APIError.failedToGetData))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(PlaylistItems.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                }
                task.resume()
            }
    }
    
    
    private func createRequest(with url: URL?,
                               type: MethodHTTP,
                               completion: @escaping (URLRequest) -> Void) {
        AuthService.shared.validToken { token in
            guard let apiUrl = url else {
                return
            }
            var request = URLRequest(url: apiUrl)
            request.setValue("Bearer \(token)",
                             forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
            
        }
    }
}
