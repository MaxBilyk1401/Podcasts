//
//  EpisodsTableViewController.swift
//  Podcasts
//
//  Created by Maxos on 4/18/23.
//

import UIKit

class EpisodsTableViewController: UITableViewController {
    
    var episodeID: String?
    var allEpisodes: [Episode] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        getEpisodes()
    }
    
    func getEpisodes() {
        guard let episodeID = episodeID else { return }
        
        let url = URL(string: "https://listen-api-test.listennotes.com/api/v2/episodes/")
        let path = "?id=\(episodeID)"
        let newUrl = url.flatMap { URL(string: $0.absoluteString + path) }
//        let newUrl = url?.appendingPathComponent("?id=\(episodeID)", isDirectory: false)
        print(newUrl!)
        let request = URLRequest(url: newUrl!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(EpisodesResult.self, from: data)

                DispatchQueue.main.async {
                    self.allEpisodes = result.episodes
                    
                    self.tableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        cell.textLabel?.text = "allEpisodes[indexPath.row].title"
        return cell
    }
}
