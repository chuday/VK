//
//  NewsTableViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit

struct news {
    var avtor: String
    var data: String
    var textNews: String
    var imageNews: UIImage
    var imageAvtor: UIImage
}

class NewsTableViewController: UITableViewController {
    
    private let cellReuseIdentifier = "NewsCell"
    var newsArray = [news]()
    var friendsVK: [FriendsVK] = []
    var groupVK: [GroupVK] = []
    var photoVK: [PhotoVK] = []
    
    var vk = NetworkManager()
    
    var newsVKArray: [NewsVK] = []
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.loadNewsVKData(userPath: "newsfeed.get") { [ weak self ] newsData in
            DispatchQueue.main.async {
                self?.newsVKArray = newsData
                self?.tableView.reloadData()
            }
        }
        
                
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        newsArray = [
            news(avtor: "Olga",
                 data: "10.02.2021",
                 textNews: "Стивен Хилленберг придумал Губку Боба в середине 90-х, в то время он преподавал биологию в Калифорнийском институте океанологии. В свободное время он рисовал комиксы о весёлом подводном жителе. Выдуманного персонажа Хилленберг называл Мальчик-Губка (англ. — Sponge Boy),но был зарегистрирован за одним моющим средством. В результате аниматор-биолог переименовал своего героя в Губку Боба.",
                 imageNews: #imageLiteral(resourceName: "f11"),
                 imageAvtor: #imageLiteral(resourceName: "f9"))
        ]
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsVKArray.count
//        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NewsTableViewCell
        
        let newsInfo = newsVKArray[indexPath.item]
        cell.textNews?.text = newsInfo.text
        cell.avtorLabel?.text = newsInfo.creatorName
        cell.configure(newsVK: newsInfo)
        
//        cell.imageAvtor.af.setImage(withURL: URL(string: newsInfo.avatarURL ?? "")!)
//         cell.imageNews.af.setImage(withURL: URL(string: newsInfo.photosURL?.first ?? "" )!)
        
        
        return cell
    }
    
}


