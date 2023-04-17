//
//  ViewController.swift
//  Podcasts
//
//  Created by Maxos on 4/14/23.
//

import UIKit

struct GenresResult: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let parentID: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentID = "parent_id"
    }
}

class ViewController: UITableViewController {
    var models: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        getGenres()
        
    }
    
    func getGenres() {
        let request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }

            do {
                let result = try JSONDecoder().decode(GenresResult.self, from: data)
//                print("Decoding \(result)")

                self.models = result.genres
                print(result.genres)
            } catch {
                print(error)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
//        let genre = models[indexPath.row]
        cell.textLabel?.text = "genre.name"
        return cell
    }
}
