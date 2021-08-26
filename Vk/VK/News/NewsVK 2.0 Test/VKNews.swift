//
//  VKNews.swift
//  VK
//
//  Created by Михаил Чудаев on 06.06.2021.
//

import UIKit
import Foundation
//import RealmSwift

class NewsVKResponce: Codable {
    let response: News
}

class News: Codable {
    let items: [NewsVK] 
}

class NewsVK: Codable {
    var postID: Int
    var text: String
    var date: Double
    var attachments: [Attachment]?
    var likes: LikeModel
    var comments: CommentModel
    var sourceID: Int
    var avatarURL: String?
    var creatorName: String?
    var photosURL: [String]? {
        get {
            let photosURL = attachments?.compactMap{ $0.photo?.sizes?.last?.url }
            return photosURL
        }
    }
    
    var newsInfo: String = ""
    
    enum CodingKeys: String, CodingKey {
        case postID = "post_id"
        case text
        case date
        case likes
        case comments
        case attachments
        case sourceID = "source_id"
        case avatarURL
        case creatorName
    }


    class Attachment: Codable {
        let type: String?
        let photo: PhotoNews?
    }
    class LikeModel: Codable {
        let count: Int
    }
    class CommentModel: Codable {
        let count: Int
    }
    
    
    class PhotoNews: Codable {
        let id: Int?
        let ownerID: Int?
        let sizes: [SizeNews]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case sizes
        }
    }
    
    class SizeNews: Codable {
        let type: String?
        let url: String?
    }

    
    class ItemsNews: Codable {
        let items: [NewsVK]
        let profiles: [ProfileNews]
        let groups: [GroupNews]
        let nextFrom: String
        
        enum CodingKeys: String, CodingKey {
            case items
            case profiles
            case groups
            case nextFrom = "next_from"
        }
    }
    class ProfileNews: Codable {
        let id: Int
        let firstName: String
        let lastName: String
        let avatarURL: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case avatarURL = "photo_100"
        }
    }
    class GroupNews: Codable {
        let id: Int
        let name: String
        let avatarURL: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case avatarURL = "photo_100"
        }
    }

}
