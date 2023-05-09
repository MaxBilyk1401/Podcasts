//  Created by Maxos on 4/14/23.

import UIKit

final class GenresViewController: UITableViewController {
    var models: [Genre] = []
    var presenter: GenrePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onRefresh()
        title = "Genre"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        let genre = models[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGenreID = String(models[indexPath.row].id)
        let nextVC = PodcastUIComposer.build(with: selectedGenreID)
        
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension GenresViewController: GenresView {
    
    func display(_ genre: [Genre]) {
        models = genre
        tableView.reloadData()
    }
}
