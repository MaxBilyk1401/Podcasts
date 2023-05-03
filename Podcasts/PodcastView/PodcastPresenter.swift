//  Created by Maxos on 5/2/23.

import Foundation

protocol PodcastView: AnyObject {
    func display(_ podcast: [Podcast])
}

final class PodcastPresenter {
    weak var view: PodcastView?
    private var genreID: String
    
    init(view: PodcastView?, genreID: String) {
        self.view = view
        self.genreID = genreID
    }
    
    func onRefresh() {
        var components = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        components.queryItems = [
            URLQueryItem(name: "genre_id", value: genreID)
        ]
        
        let request = URLRequest(url: components.url!)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(BestPodcastsResult.self, from: data)
                
                DispatchQueue.main.async {
                    self.view?.display(result.podcasts)
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
