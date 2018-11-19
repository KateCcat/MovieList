//
//  BaseView.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 20/12/2017.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//


import UIKit

class BaseView: UIView {

    private var contentView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    private func commonInit() {

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView

        contentView.frame = bounds
        addSubview(contentView)
        configureUI()
    }

    func configureUI() {

    }
}
