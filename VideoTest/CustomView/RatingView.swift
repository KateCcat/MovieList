//
//  RatingView.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit

class RatingView: BaseView {

    @IBOutlet var starsImageView: [UIImageView]!

    var ratingInt: Int = 0 {
        didSet {
            if ratingInt > 10 {
                ratingInt = 9
            }
            for index in 0...ratingInt {
                starsImageView[index].image = UIImage(named: "StarFull")
            }
        }
    }
}
