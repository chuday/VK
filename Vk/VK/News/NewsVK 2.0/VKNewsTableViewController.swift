//
//  VVTableViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 04.06.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class VKNewsTableViewController: UITableViewController {
    
    private var cellAutor = "cellAutor"
    private var cellTextPost = "cellTextPost"
    private var cellImagePost = "cellImagePost"
    private var cellBarButton = "cellBarButton"
        
    var vk = NetworkManager()
    
    var newsVKArray: [NewsVK] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        NetworkManager.shared.loadNewsVKData(userPath: "newsfeed.get") { [ weak self ] newsData in
            DispatchQueue.main.async {
                self?.newsVKArray = newsData
                self?.tableView.reloadData()
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
        return newsVKArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellAutor, for: indexPath) as! VKAutorTableViewCell
            
            let newsInfo = newsVKArray[indexPath.row]
            cell.autorPost.text = newsInfo.creatorName
//            cell.dataPost.text = newsInfo.getStringDate()
            
//            cell.postImage.af.setImage(withURL: URL(string: newsInfo.avatarURL ?? "" )!)
        
            cell.setNeedsDisplay()
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTextPost, for: indexPath) as! VKTextPostTableViewCell
            
            let newsInfo = newsVKArray[indexPath.row]
            cell.textPost?.text = newsInfo.text
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellImagePost, for: indexPath) as! VKImagePostTableViewCell
            
            let newsInfo = newsVKArray[indexPath.row]
            cell.imagePost.af.setImage(withURL: URL(string: newsInfo.photosURL?.first ?? "")!)

            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellBarButton, for: indexPath) as! VKBarButton
            let newsInfo = newsVKArray[indexPath.row]
//            cell.like.af.setImage(withURL: URL(string: newsInfo.likes.count)!)
//            cell.share.af.setImage(withURL: URL(string: newsInfo.comments.count))

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 80
        } else if indexPath.row == 1 {
            return 300
        } else if indexPath.row == 2 {
            return 350
        } else {
            return 44
        }
        
    }
}




