//
//  EpisodeUIComposer.swift
//  Podcasts
//
//  Created by Maxos on 5/3/23.
//

import UIKit

final class EpisodeUIComposer {
    static func build() -> UIViewController {
        let vc = EpisodsTableViewController()
        let presenter = EpisodePresenter()
        vc.presenter = presenter
        presenter.view = vc as? any EpisodeView 
        
        return vc
    }
}
