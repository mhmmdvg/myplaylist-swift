//
//  PlaylistViewController.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 03/09/22.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    private var playlist: [PlaylistUser] = []
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        
        configureTableView()
        fetchSong()
        
    }
    
    private func fetchSong() {
        APICaller.shared.getPlaylistUser { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.playlist = model.items
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.failedGetSongs()
                }
            }
        }
    }
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegate()
        tableView.rowHeight = 90
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: "PlaylistCell")
        tableView.pin(to: view)
        
    }
    
    private func failedGetSongs() {
        let label = UILabel(frame: .zero)
        label.text = "Failed to load Songs"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }



}

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell") as! PlaylistTableViewCell
        
        cell.set(data: playlist[indexPath.row])
        return cell
//        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailView = DetailSongsViewController()
        
        detailView.playlist = [
            PlaylistDetail(image: playlist[indexPath.row].images.first?.url,
                           name: playlist[indexPath.row].name,
                           total: playlist[indexPath.row].tracks.total,
                           description: playlist[indexPath.row].description,
                           owner: playlist[indexPath.row].owner.display_name)
        ]
        detailView.idPlaylist = playlist[indexPath.row].id
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    
}
