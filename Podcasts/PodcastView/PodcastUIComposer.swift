//  Created by Maxos on 5/3/23.

import UIKit

final class PodcastUIComposer {
    
    static func build(with genreID: String) -> UIViewController {
        let vc = PodcastsTableViewController()
        let presenter = PodcastPresenter(genreID: genreID, view: vc)
        vc.presenter = presenter
        return vc
    }
    
    private init() {}
}
