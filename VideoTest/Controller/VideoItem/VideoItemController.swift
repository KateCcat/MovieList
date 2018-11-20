//
//  VideoItemViewController.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit

class VideoItemController: UIViewController {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var ratingView: RatingView!
    var movieInfo: MovieInfo!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie"
        setupUI()
    }

    func setupUI() {
        titleLabel.text = movieInfo.title
        overviewLabel.text = movieInfo.overview
        if let rating = movieInfo.voteAverage {
            let ratingInt = Int(rating)
            ratingView.ratingInt = ratingInt
        }
        if let urlString = movieInfo.posterPath, let url = URL(string: "\(Constant.imageUrl)\(urlString)") {
            posterImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            posterImageView.image = nil
        }
    }
}
