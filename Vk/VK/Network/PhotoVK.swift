//
//  PhotoMapp.swift
//  VK
//
//  Created by Михаил Чудаев on 01.05.2021.
//

import Foundation
import RealmSwift

class PhotosResponce: Decodable {
    let response: Photos
}

class Photos: Decodable {
    let items: [PhotoVK]
}

class PhotoVK: Decodable {
    
    var albumId: Int = 0
    var ownerId: Int = 0
    var sizes: [Size] = []
    var text: String = ""
    var date: Int = 0
    var id: Int = 0
    //    @objc dynamic var albumId: Int = 0
    //    @objc dynamic var ownerId: Int = 0
    //    @objc dynamic var sizes: [Size] = []
    //    @objc dynamic var text: String = ""
    //    @objc dynamic var date: Int = 0
    //    @objc dynamic var id: Int = 0
    
    // 6
    @objc dynamic var photoInfo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case albumId = "album_id"
        case ownerId = "owner_id"
        case sizes
        case text
        case date
        case id
    }
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.albumId = try values.decode(Int.self, forKey: .albumId)
        self.ownerId = try values.decode(Int.self, forKey: .ownerId)
        self.id = try values.decode(Int.self, forKey: .id)
        self.sizes = try values.decode([Size].self, forKey: .sizes)
        
        // 6
        self.photoInfo = photoInfo
    }
}

class Size: Decodable {
    var type: String = ""
    var url: String = ""
    var width: Int = 0
    var height: Int = 0
    //    @objc dynamic var type: String = ""
    //    @objc dynamic var url: String = ""
    //    @objc dynamic var width: Int = 0
    //    @objc dynamic var height: Int = 0
}

