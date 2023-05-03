//  Created by Maxos on 5/3/23.

import Foundation

protocol EpisodeView: AnyObject {
    func display(_ episode: [Episode])
}

final class EpisodePresenter {
    weak var view: EpisodeView?
    private var episodeID: String
    
    init(view: EpisodeView?, episodeID: String) {
        self.view = view
        self.episodeID = episodeID
    }
    
    func onRefresh() {
        let url = URL(string: "https://listen-api-test.listennotes.com/api/v2/podcasts")
        let newUrl = url?.appendingPathComponent((episodeID), isDirectory: false)
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
