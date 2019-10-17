//
//  MoviesRepository.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

typealias UpcomingMovies = (Result<(movies: [Movie], totalPage: Int), Error>)

final class MoviesRepository {
    let remoteSource: MoviesRemoteSource

    private var genresCache = [Genre]()

    init(remoteSource: MoviesRemoteSource = .init()) {
        self.remoteSource = remoteSource
    }

    func fetchUpcomingMovies(page: Int, completion: @escaping (UpcomingMovies) -> Void) {
        fetchGenres { genres in
            self.remoteSource.fetchUpcomingMovies(page: page) { result in
                let mappedResult: UpcomingMovies = result.map { (MovieMapper.map(response: $0.results, genres: genres), $0.totalPages) }
                completion(mappedResult)
            }
        }
    }

    /**
     Fetches movie genres and keep them in memory for cache
     */
    private func fetchGenres(completion: @escaping ([Genre]) -> Void) {
        guard genresCache.isEmpty else {
            completion(genresCache)
            return
        }

        remoteSource.fetchGenres { result in
            switch result {
            case let .success(genres):
                self.genresCache = genres
                completion(genres)
            case .failure:
                completion([])
            }
        }
    }
}
