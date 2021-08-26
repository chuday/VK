//
//  NewsController.swift
//  
//
//  Created by Михаил Чудаев on 23.08.2021.
//

import Foundation
import Alamofire


//Расчёт размера ячеек с фотографиями

class Photo {
   let id: Int
   let date: Date
   let width: Int
   let height: Int
   let url: URL
    
    // Добавим вычисляемый параметр aspectRatio
    var aspectRatio: CGFloat { return CGFloat(height)/CGFloat(width) }
   
    init?(json: JSON) {
        guard let sizesArray = json["photo"]["sizes"].array,
            let xSize = sizesArray.first(where: { $0["type"].stringValue == "x" }),
            let url = URL(string: xSize["url"].stringValue) else { return nil }
       
        self.width = xSize["width"].intValue
        self.height = xSize["height"].intValue
        self.url = url
        let timeInterval = json["date"].doubleValue
        self.date = Date(timeIntervalSince1970: timeInterval)
        self.id = json["id"].intValue
    }
 }

override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.row {
    // Ячейки с фото у нас, например, имеют .row == 2
    case 2:
            // Вычисляем высоту
            let tableWidth = tableView.bounds.width
            let news = self.news[indexPath.section]
            let cellHeight = tableWidth * news.aspectRatio
            return cellHeight
    default:
    // Для всех остальных ячеек оставляем автоматически определяемый размер
            return UITableView.automaticDimension
       
    }
}
