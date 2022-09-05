//
//  DetailSongsViewController.swift
//  MyPlaylist
//
//  Created by Muhammad Vikri on 04/09/22.
//

import UIKit

class DetailSongsViewController: UIViewController {
    
    var idPlaylist: String = ""
    var playlist: [PlaylistDetail] = []
    private var songs: [Playlist] = []

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        
        
        return tableView
    }()
    
    private let tesLabel: UILabel = {
        let tesLabel = UILabel()
        tesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return tesLabel
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        view.backgroundColor = .systemBackground

        configureTableView()
        fetchSongs()
        
    }
    
    private func fetchSongs() {
        APICaller.shared.getPlaylistSong(id: idPlaylist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let model):
                        self?.songs = model.items
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error.localizedDescription)
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
        tableView.rowHeight = 60
        tableView.register(SongsTableViewCell.self, forCellReuseIdentifier: "SongsCell")
        tableView.register(SongsTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "SongsHeader")
        tableView.register(SongsTableViewFooter.self, forHeaderFooterViewReuseIdentifier: "SongsFooter")
        tableView.pin(to: view)
        
    }


}

extension DetailSongsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SongsHeader") as? SongsTableViewHeader
        
        header?.set(image: playlist.first?.image, namePlaylist: playlist.first?.name, ownerName: playlist.first?.owner, description: playlist.first?.description)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongsCell") as! SongsTableViewCell
        
        cell.backgroundColor = .systemBackground
        cell.set(data: songs[indexPath.row])

           return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SongsFooter") as? SongsTableViewFooter
        
        footer?.set(totalSongs: playlist.first?.total)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
}
