//
//  UpcomingMoviesViewModel.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Foundation

final class UpcomingMoviesViewModel {
    static let numberOfItemsInPage = 20
    private var totalPageCount = 1
    private var currentPage = 1
    
    private let repository: MoviesRepository
    
    var startLoading: (() -> Void)?
    var stopLoading: (() -> Void)?
    var startPaginationLoading: (() -> Void)?
    var showPaginationError: (() -> Void)?
    var showError: ((String) -> Void)?
    var reloadList: (() -> Void)?
    
    private var requestBeingMade = false
    private var lastRequestFailed = false

    private(set) var movies = [MovieViewData]()
    
    var shouldPaginate: Bool {
        let isLastPage = currentPage > totalPageCount
        return !requestBeingMade && !lastRequestFailed && !isLastPage
    }
    
    init(repository: MoviesRepository = .init()) {
        self.repository = repository
    }
    
    func fetchUpcomingMovies() {
        guard !requestBeingMade else { return }

        showLoadingState()

        startRequest()
        
        repository.fetchUpcomingMovies(page: currentPage) { [weak self] result in
            switch result {
            case let .success(response):
                let viewDatas = response.movies.map { MovieViewData(movie: $0) }
                self?.movies.append(contentsOf: viewDatas)
                                
                self?.currentPage += 1
                self?.totalPageCount = response.totalPage
                
                self?.stopLoading?()
                self?.reloadList?()
                self?.finishRequest(withError: false)
            case let .failure(error):
                self?.showErrorState(error: error)
                self?.finishRequest(withError: true)
            }
        }
    }
    
    private func showLoadingState() {
        let firstRequest = movies.isEmpty
        
        if firstRequest {
            startLoading?()
        } else {
            startPaginationLoading?()
        }
    }
    
    private func showErrorState(error: Error) {
        let firstRequest = movies.isEmpty
               
        if firstRequest {
            showError?(error.localizedDescription)
        } else {
            showPaginationError?()
        }
    }

    private func startRequest() {
        requestBeingMade = true
        lastRequestFailed = false
    }

    private func finishRequest(withError error: Bool) {
        requestBeingMade = false
        lastRequestFailed = error
    }
}
