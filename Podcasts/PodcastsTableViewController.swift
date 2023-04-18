//
//  PodcastsTableViewController.swift
//  Podcasts
//
//  Created by Maxos on 4/17/23.
//

import UIKit

final class PodcastsTableViewController: UITableViewController {

    var genreID: Int?
    var allPodcasts: [Podcasts] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Podcasts"
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getPodcasts), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        getPodcasts()
    }
    
    @objc
    func getPodcasts() {
        guard let genreID = genreID else { return }
        
        var components = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        components.queryItems = [
            URLQueryItem(name: "genre_id", value: String(genreID))
        ]
        print(components)
        
        let request = URLRequest(url: components.url!)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(PodcastsResult.self, from: data)

                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self.allPodcasts = result.podcasts
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                })
            } catch {
                DispatchQueue.main.async {
                    print(error)
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
        self.tableView.refreshControl?.beginRefreshing()
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
//        cell.imageView?.image = podcast.image
        return cell
    }
}
