//
//  PodcastsTableViewController.swift
//  Podcasts
//
//  Created by Maxos on 4/17/23.
//

import UIKit

final class PodcastsTableViewController: UITableViewController {
    private var allPodcasts: [Podcast] = []
    var genreID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Podcasts"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        getPodcasts()
    }
    
    func getPodcasts() {
        guard let genreID = genreID else { return }
        
        var components = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        components.queryItems = [
            URLQueryItem(name: "genre_id", value: String(genreID))
        ]
        
        let request = URLRequest(url: components.url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(BestPodcastsResult.self, from: data)

                DispatchQueue.main.async {
                    self.allPodcasts = result.podcasts
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
        return allPodcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        let podcast = allPodcasts[indexPath.row]
        cell.textLabel?.text = podcast.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EpisodsTableViewController()
        vc.episodeID = allPodcasts[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
