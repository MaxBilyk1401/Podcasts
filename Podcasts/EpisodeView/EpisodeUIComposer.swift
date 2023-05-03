//  Created by Maxos on 5/3/23.

import UIKit

final class EpisodeUIComposer {
    static func build(with podcastID: String) -> UIViewController {
        let vc = EpisodsTableViewController()
        let presenter = EpisodePresenter(view: vc, episodeID: podcastID)
        vc.presenter = presenter
        presenter.view = vc
        
        return vc
    }
}
