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
    
    var vk = NetworkManager()

  
    
    private let cellReuseIdentifier = "NewsCell"
    
    var newsArray = [news]()
    
    var friendsMap: [FriendsMap] = []
    var groupMapp: [GroupMapp] = []
    var photoMapp: [PhotoMapp] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//         Запуск Mapp 3й урок
        
        
//       NetworkManager.shared.userMapp(userPath: "friends.get") { [weak self] friendData in
//            DispatchQueue.main.async {
//                self?.friendsMap = friendData
//            print("Friends array: \(self?.friendsMap.map { $0.firstName + " " + $0.lastName }) ")
//
//            }
//        }
        
//       NetworkManager.shared.groupMapp(userPath: "groups.get") { [weak self] groupData in
//                    DispatchQueue.main.async {
//                        self?.groupMapp = groupData
//                        print("Group array: \(self?.groupMapp.map { $0.name}) ")
//
//                    }
//                }

//        NetworkManager.shared.photoMapp(userPath: "photos.get") { [weak self] photoData in
//                          DispatchQueue.main.async {
//                              self?.photoMapp = photoData
//                            print("Photo array: \(self?.photoMapp.map { $0.id}) ")
//
//                          }
//                      }
        
        
        
//        vk.searchGroups(searchField: "orenburg_vk")
//        vk.loadData(getData: "groups.get")
//        vk.loadData(getData: "friends.get")
//        vk.loadUserData(data: "users.get", userId: "136959229")
        vk.loadPhotoData(userId: "136959229")
        
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    
        newsArray = [
        news(avtor: "Olga", data: "10.02.2021", textNews: "Стивен Хилленберг придумал Губку Боба в середине 90-х, в то время он преподавал биологию в Калифорнийском институте океанологии. В свободное время он рисовал комиксы о весёлом подводном жителе. Выдуманного персонажа Хилленберг называл Мальчик-Губка (англ. — Sponge Boy),но был зарегистрирован за одним моющим средством. В результате аниматор-биолог переименовал своего героя в Губку Боба.", imageNews: #imageLiteral(resourceName: "f11"), imageAvtor: #imageLiteral(resourceName: "f9"))
        ]
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NewsTableViewCell
        
        let news = newsArray[indexPath.item]
        cell.avtorLabel.text = "\(news.avtor)"
        cell.dataLabel.text = "\(news.data)"
        cell.textNews.text = "\(news.textNews)"
        cell.imageNews.image = news.imageNews
        cell.imageAvtor.image = news.imageAvtor
        
        return cell
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
