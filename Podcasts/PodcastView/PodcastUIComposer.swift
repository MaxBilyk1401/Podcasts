//  Created by Maxos on 5/3/23.

import UIKit

final class PodcastUIComposer {
    static func build(with id: Int?) -> UIViewController {
        let vc = PodcastsTableViewController()
        let presenter = PodcastPresenter()
        vc.presenter = presenter
        presenter.view = vc as? any PodcastView
        
        return vc
    }
    private init() {}
}
