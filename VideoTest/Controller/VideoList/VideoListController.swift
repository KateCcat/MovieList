//
//  VideoListController.swift
//  VideoTest
//
//  Created by Екатерина Протасова on 16/11/2018.
//  Copyright © 2018 Екатерина Протасова. All rights reserved.
//
import UIKit

class VideoListController: UIViewController {

    var videoList: [MovieInfo] = []
    private var currentPage = 1
    private var shouldShowLoadingCell = false

    @IBOutlet fileprivate var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.tableFooterView = UIView(frame: .zero)
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "\(VideoListCell.self)", bundle: nil), forCellReuseIdentifier: "\(VideoListCell.self)")
            tableView.register(UINib(nibName: "\(LoadingCell.self)", bundle: nil), forCellReuseIdentifier: "\(LoadingCell.self)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshMovieList), for: .valueChanged)
        tableView.refreshControl?.beginRefreshing()
        loadMovieList()
    }

    func loadMovieList(refresh: Bool = false) {
        DataManager.shared.getAllVideo(page: "\(currentPage)") { result, error in
            if let movieList = result {
                self.shouldShowLoadingCell = movieList.page ?? 1 < movieList.totalPages ?? 1
                if refresh {
                    self.videoList = movieList.results ?? []
                } else {
                    for video in movieList.results ?? [] {
                        if !self.videoList.contains(video) {
                            self.videoList.append(video)
                        }
                    }
                }
            }

            self.tableView.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    @objc
    func refreshMovieList() {
        currentPage = 1
        loadMovieList(refresh: true)
    }

    private func fetchNextPage() {
        currentPage += 1
        loadMovieList()
    }
}

extension VideoListController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shouldShowLoadingCell ? videoList.count + 1 : videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if isLoadingIndexPath(indexPath) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(LoadingCell.self)", for: indexPath) as? LoadingCell {
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoListCell.self)", for: indexPath) as? VideoListCell {
                cell.numberLabel.text = "\(indexPath.row + 1)"
                cell.video = videoList[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension VideoListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let controller: VideoItemController = storyboard.instantiateViewController(withIdentifier: "\(VideoItemController.self)") as? VideoItemController {
            controller.movieInfo = videoList[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard isLoadingIndexPath(indexPath) else {
            return
        }
        fetchNextPage()
    }

    func isLoadingIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else {
            return false
        }
        return indexPath.row == self.videoList.count
    }
}
