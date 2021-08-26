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
    
    // Функция настройки контроллера
    fileprivate func setupRefreshControl() {
        // Инициализируем и присваиваем сущность UIRefreshControl
        refreshControl = UIRefreshControl()
        // Настраиваем свойства контрола, как, например,
        // отображаемый им текст
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing...")
        // Цвет спиннера
        refreshControl?.tintColor = .red
        // И прикрепляем функцию, которая будет вызываться контролом
        refreshControl?.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
    }
    
    var nextFrom = ""
    var isLoading = false
    
    let dispatchGroup = DispatchGroup()
    
    private let cellReuseIdentifier = "NewsCell"
    var newsArray = [news]()
    
    
    
    var vk = NetworkManager()
    
    var newsVKArray: [NewsVK] = []
    
    private func getNewsData() {
        NetworkManager.shared.loadNewsVKData(userPath: "newsfeed.get") { [ weak self ] newsData in
            DispatchQueue.main.async {

                self?.newsVKArray = newsData
                
//                print("Response likes: \(self?.newsVKArray.map {$0.likes.count})")
//                print("Response comments: \(self?.newsVKArray.map {$0.comments.count})")

                self?.tableView.reloadData()
            }
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print(self.newsVKArray)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Указываем, что мы делегат
        tableView.prefetchDataSource = self
        
//        setipRefreshControl()
        
        getNewsData()
//                NetworkManager.shared.loadNewsVKData(userPath: "newsfeed.get") { [ weak self ] newsData in
//                    DispatchQueue.main.async {
//                        self?.newsVKArray = newsData
//                        self?.tableView.reloadData()
//                    }
//                }
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
        cell.avtorLabel?.text = newsInfo.text
        cell.configure(newsVK: newsInfo)

        if let urlStringAvatar = newsInfo.avatarURL, let url = URL(string: urlStringAvatar) {
            cell.imageAvtor.af.setImage(withURL: url)
        }
        
        if let urlStringPhotos = newsInfo.photosURL, let url = URL(string: urlStringPhotos.first ?? "") {
            cell.imageNews.af.setImage(withURL: url)
        }
            
//        cell.imageNews.af.setImage(withURL: URL(string: newsInfo.photosURL?.first ?? "" )!)
        
        return cell
    }
    
    
    @objc func refreshNews() {
//          // Начинаем обновление новостей
//          self.refreshControl?.beginRefreshing()
//          // Определяем время самой свежей новости
//          // или берем текущее время
//          let mostFreshNewsDate = self.newsVKArray.first?.date ?? Date().timeIntervalSince1970
//          // отправляем сетевой запрос загрузки новостей
//        NetworkManager.shared.loadNewsVKData(userPath: "newsfeed.get") { [ weak self ] news in
//              guard let self = self else { return }
//              // выключаем вращающийся индикатор
//              self.refreshControl?.endRefreshing()
//              // проверяем, что более свежие новости действительно есть
//              guard news.count > 0 else { return }
//              // прикрепляем их в начало отображаемого массива
//            self.newsVKArray = news + self.newsVKArray
//              // формируем IndexSet свежедобавленных секций и обновляем таблицу
//              let indexSet = IndexSet(integersIn: 0..<news.count)
//              self.tableView.insertSections(indexSet, with: .automatic)
//          }
      }
}
    extension NewsTableViewController: UITableViewDataSourcePrefetching {
       func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
           // Выбираем максимальный номер секции, которую нужно будет отобразить в ближайшее время
           guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
           // Проверяем,является ли эта секция одной из трех ближайших к концу
           if maxSection > newsVKArray.count - 3,
               // Убеждаемся, что мы уже не в процессе загрузки данных
               !isLoading {
               // Начинаем загрузку данных и меняем флаг isLoading
               isLoading = true
               // Обратите внимание, что сетевой сервис должен уметь обрабатывать входящий параметр nextFrom
//            NetworkManager.newsRequest(startFrom: nextFrom)
            NetworkManager.shared.newsRequest(startFrom: nextFrom)
               // и в качестве результата возвращать не только свежераспарсенные новости, но и nextFrom для будущего запроса
               { [weak self] (news, nextFrom) in
                   guard let self = self else { return }
                   // Прикрепляем новости к cуществующим новостям
                let indexSet = IndexSet(integersIn: self.newsVKArray.count ..< self.newsVKArray.count + self.newsVKArray.count)
//                self.news.append(contentsOf: news)
                // Обновляем таблицу
                self.tableView.insertSections(indexSet, with: .automatic)
                // Выключаем статус isLoading
                self.isLoading = false
            }
        }
      }
    }

    



