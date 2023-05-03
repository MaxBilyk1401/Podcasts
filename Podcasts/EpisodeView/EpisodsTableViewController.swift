//  Created by Maxos on 4/18/23.

import UIKit

final class EpisodsTableViewController: UITableViewController {
    private var allEpisodes: [Episode] = []
    var episodeID: String?
    var presenter: EpisodePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEpisodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        cell.textLabel?.text = allEpisodes[indexPath.row].title
        return cell
    }
}
