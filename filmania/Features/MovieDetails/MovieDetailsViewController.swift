//
//  MovieDetailsViewController.swift
//  filmania
//
//  Created by Matheus Fróes on 16/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Kingfisher
import UIKit

final class MovieDetailsViewController: UIViewController {
    @IBOutlet private var imageViewBackdrop: UIImageView!
    @IBOutlet private var imageViewPoster: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var labelMovieReleaseDate: UILabel!
    @IBOutlet private var labelMovieTitle: UILabel!
    @IBOutlet private var labelMovieGenres: UILabel!
    @IBOutlet private var labelMovieOverview: UILabel!

    private var movieViewData: MovieViewData!

    static func newInstance(movieViewData: MovieViewData) -> MovieDetailsViewController {
        let viewController = MovieDetailsViewController.instantiate(fromStoryboard: "MovieDetails")
        viewController.movieViewData = movieViewData
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieViewData.title

        scrollView.alwaysBounceVertical = true

        configureImageViewPoster()

        labelMovieTitle.text = movieViewData.title
        labelMovieGenres.text = movieViewData.genres
        labelMovieOverview.text = movieViewData.overview
        labelMovieReleaseDate.text = movieViewData.releaseDate
        imageViewPoster.kf.setImage(with: movieViewData.posterURL)
        imageViewBackdrop.kf.setImage(with: movieViewData.backdropURL)
    }

    private func configureImageViewPoster() {
        imageViewPoster.layer.cornerRadius = 6
        imageViewPoster.layer.masksToBounds = true
        imageViewPoster.layer.borderColor = UIColor.white.cgColor
        imageViewPoster.layer.borderWidth = 2
    }
}
