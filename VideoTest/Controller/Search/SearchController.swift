//
//  SearchController.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 22/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//

import UIKit

class SearchController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "\(VideoListCell.self)", bundle: nil), forCellReuseIdentifier: "\(VideoListCell.self)")
            tableView.tableHeaderView = UIView()
            tableView.estimatedSectionHeaderHeight = 50
        }
    }
    @IBOutlet var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search movie"
        }
    }
    var movieList: [MovieInfo] = []
    var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        activityIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.7, y: view.frame.size.height * 0.7)
    }

    func searchMovie(query: String) {
        DataManager.shared.searchMovie(page: "1", query: "\(query)") { result, error in
            if let movieList = result {
                self.movieList = movieList.results ?? []

                self.activityIndicator.stopAnimating() // On response stop animating
                self.activityIndicator.removeFromSuperview() // remove the view

            }
             self.tableView.reloadData()
        }
    }
}

extension SearchController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoListCell.self)", for: indexPath) as? VideoListCell {
            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.video = movieList[indexPath.row]
            return cell
        } else {

            return UITableViewCell()
        }
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText .isEmpty {
            self.movieList = []
            self.tableView.reloadData()
        } else {
            activityIndicator.startAnimating()
            self.searchMovie(query: searchText)
        }

    }
}
