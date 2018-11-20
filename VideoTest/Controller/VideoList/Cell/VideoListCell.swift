//
//  VideoListCell.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit
import Kingfisher

class VideoListCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var ratingView: RatingView!
    @IBOutlet var posterImageView: UIImageView!

    var video: MovieInfo! {
        didSet {
            titleLabel.text = video.title

            if let dateString = video.releaseDate, let date = DateFormatter.date(jsonString: dateString), let text = DateFormatter.tableDateString(from: date) {
            yearLabel.text = text
            }
            if let rating = video.voteAverage {
                let ratingInt = Int(rating)
                ratingView.ratingInt = ratingInt
            }
            if let urlString = video.posterPath, let url = URL(string: "\(Constant.imageUrl)\( urlString)") {
                posterImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
            } else {
                posterImageView.image = nil
            }
        }
    }
}
