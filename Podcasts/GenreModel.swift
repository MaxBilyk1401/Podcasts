//
//  GenreModel.swift
//  Podcasts
//
//  Created by Maxos on 4/14/23.
//

import Foundation

struct GenresResult: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let parent_id: Int
}

private enum CodingKeys: String, CodingKey {
    case id
    case name
    case parentId = "parent_id"
}
