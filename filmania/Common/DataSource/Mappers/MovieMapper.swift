//
//  MovieMapper.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

/**
 Converts from the network `MovieResponse` to the app  `Movie` model
 */
struct MovieMapper {
    static func map(response: MovieResponse, genres: [Genre]) -> Movie? {
        guard let releaseDate = response.releaseDate.toDate(usingFormat: "yyyy-MM-dd") else {
            return nil
        }

        return Movie(
            title: response.title,
            posterPath: response.posterPath,
            overview: response.overview,
            genres: genres.filter { genre in response.genreIds.contains(genre.id) },
            releaseDate: releaseDate,
            backdropPath: response.backdropPath
        )
    }

    static func map(response: [MovieResponse], genres: [Genre]) -> [Movie] {
        return response.compactMap { map(response: $0, genres: genres) }
    }
}
