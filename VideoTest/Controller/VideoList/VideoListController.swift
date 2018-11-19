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
    
    @IBOutlet fileprivate var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(UINib(nibName: "\(VideoListCell.self)", bundle: nil), forCellReuseIdentifier: "\(VideoListCell.self)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.getAllVideo(text: "") { (result, error) in
            self.videoList = result ?? []
            self.tableView.reloadData()
        }
    }
}

extension VideoListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "\(VideoListCell.self)", for: indexPath) as? VideoListCell {
            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.video = videoList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension VideoListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller: VideoItemController  =  storyboard.instantiateViewController(withIdentifier: "\(VideoItemController.self)") as! VideoItemController
        controller.movieInfo =  videoList[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}






