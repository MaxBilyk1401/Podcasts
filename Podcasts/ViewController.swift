//
//  ViewController.swift
//  Podcasts
//
//  Created by Maxos on 4/14/23.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getGenres()
    }
    
    func getGenres() {
        var request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GenresResult.self, from: data)
                print(result)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
}
