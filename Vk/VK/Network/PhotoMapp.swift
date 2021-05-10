//
//  PhotoMapp.swift
//  VK
//
//  Created by Михаил Чудаев on 01.05.2021.
//

import Foundation

    class PhotosResponce: Decodable {
        let response: Photos
    }

    class Photos: Decodable {
        let items: [PhotoMapp]
    }

class PhotoMapp: Decodable {
    
    var albumId: Int = 0
    var ownerId: Int = 0
//    var userId: Int = 0
//    var size: [Size] = []
//    var text: String = ""
//    var date: Int = 0
//    var url: String = ""
//    var id: Int = 0
    
    
        enum CodingKeys: String, CodingKey {
            case albumId = "album_id"
            case ownerId = "owner_id"
//            case userId = "user_id"
//            case size
//            case text
//            case date
//            case url
//            case id 
        }
        convenience required init(from decoder: Decoder) throws {
            self.init()
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.albumId = try values.decode(Int.self, forKey: .albumId)
            self.ownerId = try values.decode(Int.self, forKey: .ownerId)
//            self.url = try values.decode(String.self, forKey: .url)
//            self.userId = try values.decode(Int.self, forKey: .userId)
//            self.id = try values.decode(Int.self, forKey: .id)
        }

class Size: Decodable {
    var type: String = ""
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    }
}

