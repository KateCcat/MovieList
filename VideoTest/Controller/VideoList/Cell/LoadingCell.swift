//
//  LoadingCell.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 20/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
    }
}
