//
//  MyRouter.swift
//  Podcasts
//
//  Created by Maxos on 5/1/23.
//

import Foundation
import UIKit

class MyRouter {
    weak var navigationController: UINavigationController?
    
    func showNextScreen(with id: Int) {
        let nextVC = PodcastsTableViewController()
        nextVC.genreID = id
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
