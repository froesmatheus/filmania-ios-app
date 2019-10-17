//
//  MoviesRemoteSource.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

final class MoviesRemoteSource {
    private let session: URLSession

    private let apiKey = "c5850ed73901b8d268d0898a8a9d8bff"

    private var baseURL: URLComponents {
        var components = URLComponents(string: "https://api.themoviedb.org/3/")!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US"),
        ]
        return components
    }

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let genresURL = "genre/movie/list"

        let url = baseURL.url!.appendingPathComponent(genresURL)

        makeRequest(with: url, response: GenresResponse.self) { result in
            completion(result.map { $0.genres })
        }
    }

    func fetchUpcomingMovies(page: Int, completion: @escaping (Result<MoviesResponse, Error>) -> Void) {
        let moviesURL = "movie/upcoming"

        var baseURL = self.baseURL
        baseURL.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        
        let url = baseURL.url!.appendingPathComponent(moviesURL)

        makeRequest(with: url, response: MoviesResponse.self, completion: completion)
    }

    private func makeRequest<Response: Decodable>(with url: URL, response _: Response.Type, completion: @escaping (Result<Response, Error>) -> Void) {
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                dispatch { completion(.failure(error)) }
                return
            }

            guard let data = data else {
                dispatch { completion(.failure(RuntimeError("Unable to make request"))) }
                return
            }

            if let modelResponse = parseJSON(from: data, to: Response.self) {
                dispatch { completion(.success(modelResponse)) }
            } else if let errorResponse = parseJSON(from: data, to: APIError.self) {
                dispatch { completion(.failure(errorResponse)) }
            } else {
                dispatch { completion(.failure(RuntimeError("There was an error while mapping the network response"))) }
            }
        }.resume()

        func dispatch(block: @escaping () -> Void) {
            DispatchQueue.main.async(execute: block)
        }
    }
}

private func parseJSON<Model: Decodable>(from data: Data, to _: Model.Type) -> Model? {
    do {
        return try JSONDecoder().decode(Model.self, from: data)
    } catch {
        print(error)
    }
    
    return nil
}
