//  Created by Maxos on 5/3/23.

import UIKit

final class EpisodeUIComposer {
    
    static func build(with podcastID: String) -> UIViewController {
        let vc = EpisodsTableViewController()
        let presenter = EpisodePresenter(episodeID: podcastID, view: vc)
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
    
    private init() {}
}
