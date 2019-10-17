//
//  MovieViewData.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

/**
 Represents a `Movie` object displayed on the user interface
 */
final class MovieViewData {
    private let movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    var title: String {
        return movie.title
    }

    var overview: String {
        return movie.overview
    }

    var genres: String {
        return movie.genres
            .map { $0.name }
            .joined(separator: ", ")
    }

    var releaseDate: String {
        return movie.releaseDate.toString(usingFormat: "dd/MM/yyyy")
    }

    var posterURL: URL? {
        if let posterPath = movie.posterPath {
            return createImageURL(path: posterPath)
        }
        
        return nil
    }

    var backdropURL: URL? {
        if let backdropPath = movie.backdropPath {
            return createImageURL(path: backdropPath)
        }
        
        return nil
    }
    
    private func createImageURL(path: String) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w780/\(path)")!
    }
}


