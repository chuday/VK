//
//  VVTableViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 04.06.2021.
//

import UIKit

class VKNewsTableViewController: UITableViewController {
    
    private var cellAutor = "cellAutor"
    private var cellTextPost = "cellTextPost"
    private var cellImagePost = "cellImagePost"
    private var cellBarButton = "cellBarButton"
    
    var vk = NetworkManager()
    
    var newsVKArray: [NewsVK] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vk.loadNewsVKData(userPath: "newsfeed.get")
        
        }
        
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellAutor, for: indexPath) as! VKAutorTableViewCell
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellTextPost, for: indexPath) as! VKTextPostTableViewCell
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellImagePost, for: indexPath) as! VKImagePostTableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellBarButton, for: indexPath) as! VKBarButton
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




