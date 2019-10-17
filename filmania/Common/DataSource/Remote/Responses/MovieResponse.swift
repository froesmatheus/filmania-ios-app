//
//  MovieResponse.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct MovieResponse: Decodable {
    let title: String
    let posterPath: String?
    let overview: String
    let genreIds: [Int]
    let releaseDate: String
    let backdropPath: String?

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case overview
        case genreIds = "genre_ids"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}
