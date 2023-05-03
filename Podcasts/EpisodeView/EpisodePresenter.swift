//
//  EpisodePresenter.swift
//  Podcasts
//
//  Created by Maxos on 5/3/23.
//

import Foundation

protocol EpisodeView: AnyObject {
    func display(_ episode: [Episode])
}

class EpisodePresenter {
    weak var view: EpisodeView?
    
    func onRefresh() {
        let url = URL(string: "https://listen-api-test.listennotes.com/api/v2/podcasts")
        let newUrl = url?.appendingPathComponent((""), isDirectory: false)
        let request = URLRequest(url: newUrl!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(EpisodesResult.self, from: data)
                DispatchQueue.main.async {
                    self.view?.display(result.episodes)
                }
            } catch {
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
