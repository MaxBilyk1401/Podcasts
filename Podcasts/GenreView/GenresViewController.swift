//  Created by Maxos on 4/14/23.

import UIKit

class GenresViewController: UITableViewController {
    private var models: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Genres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        getGenres()
    }
    
    private func getGenres() {
        let request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GenresResult.self, from: data)
                
                DispatchQueue.main.async {
                    self.models = result.genres
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
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))!
        let genre = models[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(
            withIdentifier: String(describing: PodcastsTableViewController.self)
        ) as? PodcastsTableViewController {
            vc.genreID = models[indexPath.row].id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}