//  Created by Maxos on 4/14/23.

import UIKit

/*
 View -> Presenter
 onRefresh
 select(Genre)
 
 Presenter -> View
 display([genre])
 display(isLoading: Bool)
 display error(optional)
 */

class GenresViewController: UITableViewController {
    var models: [Genre] = []
    var presenter = GenrePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.onRefresh()
        title = "Genre"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        
        let router = MyRouter()
        router.navigationController = navigationController
        
        let presenter = GenrePresenter()
        presenter.router = router
        
        self.presenter = presenter
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
        let genre = models[indexPath.row]
        presenter.onSelect(genre)
        let selectedGenre = models[indexPath.row].id
        presenter.cellTapped(with: selectedGenre)
    }
}

extension GenresViewController: GenresView {
    func goToNextPage() {
        let vc = PodcastsTableViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func display(_ genre: [Genre]) {
        models = genre
        tableView.reloadData()
    }
}
