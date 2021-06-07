//
//  FriendsMapp.swift
//  VK
//
//  Created by Михаил Чудаев on 01.05.2021.
//

import Foundation
import RealmSwift

class FriendsResponce: Decodable {
    let response: Friends
}

class Friends: Decodable {
    let items: [FriendsVK]
}

class FriendsVK: Object, Decodable {
    
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var avatar: String = ""
    @objc dynamic var id: Int = 0
    
    // 6
    @objc dynamic var friendInfo: String = ""
    
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
        
        // 6
        self.friendInfo = friendInfo
    }
}
