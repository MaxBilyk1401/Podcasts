//  Created by Maxos on 5/2/23.

import UIKit

final class GenresUIComposer {
    static func build(with id: Int?) -> UIViewController {
        let vc = GenresViewController()
        let presenter = GenrePresenter()
        vc.presenter = presenter
        presenter.view = vc as any GenresView
        
        return vc
    }
    private init() {
}
}
