//
//  UpcomingMoviesViewController.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {
    private var viewModel: UpcomingMoviesViewModel!

    @IBOutlet private var tableView: UITableView!
    
    private lazy var loadingView = LoadingViewManager(delegate: self)
    
    private lazy var paginationLoadingView: PaginationLoadingView = {
        let frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 65)
        let view = PaginationLoadingView(frame: frame)
        view.delegate = self
        return view
    }()
    
    static func newInstance(viewModel: UpcomingMoviesViewModel = .init()) -> UpcomingMoviesViewController {
        let viewController = UpcomingMoviesViewController.instantiate(fromStoryboard: "UpcomingMovies")
        viewController.viewModel = viewModel
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filmania"
        
        configureTableView()
        bindViewModel()
        
        viewModel.fetchUpcomingMovies()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: MovieTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = paginationLoadingView
        tableView.tableFooterView?.isHidden = false
    }
    
    private func bindViewModel() {
        viewModel.startLoading = { [unowned self] in
            self.loadingView.showLoading(superView: self.view)
        }
        viewModel.stopLoading = { [unowned self] in
            self.loadingView.removeLoading()
            self.paginationLoadingView.hideLoading()
        }
        viewModel.startPaginationLoading = { [unowned self] in
            self.paginationLoadingView.showLoading()
        }
        viewModel.showPaginationError = { [unowned self] in
            self.paginationLoadingView.showError()
        }
        viewModel.showError = { [unowned self] message in
            self.loadingView.showError(superView: self.view, message: message)
        }
        viewModel.reloadList = { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    private func goToMovieDetails(_ movie: MovieViewData) {
        let controller = MovieDetailsViewController.newInstance(movieViewData: movie)
        show(controller, sender: nil)
    }
}


extension UpcomingMoviesViewController: LoadingViewDelegate, PaginationLoadingDelegate {
    func didTapTryAgain() {
        viewModel.fetchUpcomingMovies()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension UpcomingMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell

        let movie = viewModel.movies[indexPath.row]

        cell.configure(with: movie)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = viewModel.movies[indexPath.row]

        goToMovieDetails(movie)
    }
}

// MARK: Pagination

extension UpcomingMoviesViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let lastIndexVisible = tableView.indexPathsForVisibleRows?.last {
            if shouldPaginate(lastIndexVisible) {
                viewModel.fetchUpcomingMovies()
            }
        }
    }

    private func shouldPaginate(_ lastIndexVisible: IndexPath) -> Bool {
        guard viewModel.shouldPaginate else { return false }

        return viewModel.movies.count - lastIndexVisible.row < UpcomingMoviesViewModel.numberOfItemsInPage / 2
    }
}
