//
//  Movie.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

struct Movie {
    let title: String
    let posterPath: String?
    let overview: String
    let genres: [Genre]
    let releaseDate: Date
    let backdropPath: String?
}
