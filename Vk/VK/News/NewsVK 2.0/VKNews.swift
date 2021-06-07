//
//  VKNews.swift
//  VK
//
//  Created by Михаил Чудаев on 06.06.2021.
//

import Foundation
import RealmSwift

class NewsVKResponce: Decodable {
    let response: NewsVK
}

class News: Decodable {
    let items: [NewsVK]
}

class NewsVK: Decodable {

    var firstName: String = ""
    var lastName: String = ""
    var avatar: String = ""
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
        case id
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decode(String.self, forKey: .firstName)
        self.lastName = try values.decode(String.self, forKey: .lastName)
        self.id = try values.decode(Int.self, forKey: .id)
        self.avatar = try values.decode(String.self, forKey: .avatar)
    }
}
