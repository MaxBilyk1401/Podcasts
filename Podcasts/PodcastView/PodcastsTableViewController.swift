//  Created by Maxos on 4/17/23.

import UIKit

final class PodcastsTableViewController: UITableViewController {
    private var allPodcasts: [Podcast] = []
    var presenter: PodcastPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Podcasts"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        presenter.onRefresh()
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
        let selectedPodcastID = allPodcasts[indexPath.row].id
        let episodesVC = EpisodeUIComposer.build(with: selectedPodcastID)
        
        self.navigationController?.pushViewController(episodesVC, animated: true)
    }
}

extension PodcastsTableViewController: PodcastView {
    func display(_ podcast: [Podcast]) {
        allPodcasts = podcast
        tableView.reloadData()
    }
}
