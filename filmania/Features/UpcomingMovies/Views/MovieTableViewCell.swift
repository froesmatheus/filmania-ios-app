//
//  MovieTableViewCell.swift
//  filmania
//
//  Created by Matheus Fróes on 15/10/19.
//  Copyright © 2019 Matheus Fróes. All rights reserved.
//

import Kingfisher
import UIKit

final class MovieTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"

    @IBOutlet private var labelMovieName: UILabel!
    @IBOutlet private var labelMovieGenres: UILabel!
    @IBOutlet private var labelReleaseDate: UILabel!
    @IBOutlet private var imageViewMovieCover: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        imageViewMovieCover.layer.cornerRadius = 6
        imageViewMovieCover.layer.masksToBounds = true
    }

    func configure(with movieViewData: MovieViewData) {
        labelMovieName.text = movieViewData.title
        labelMovieGenres.text = movieViewData.genres
        labelReleaseDate.text = movieViewData.releaseDate
        imageViewMovieCover.kf.setImage(with: movieViewData.posterURL)
    }
}
