//
//  Episodes.swift
//  Podcasts
//
//  Created by Maxos on 4/18/23.
//

import Foundation

struct Episode: Decodable {
    let episodes: Episodes?
    
    struct Episodes: Decodable {
        let title: String?
        let description: String?
        let image: String?
        let id: String?
    }
}
