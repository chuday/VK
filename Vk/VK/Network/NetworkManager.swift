//
//  NetworkManager.swift
//  VK
//
//  Created by Михаил Чудаев on 21.04.2021.


import Foundation
import Alamofire
import AlamofireImage
import PromiseKit


class NetworkManager {
        
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.vk.com"
    let apiKey = Sessions.shared.token
    
    func loadData(getData: String){
        let path = "/method/" + getData
        let methodName: Parameters = [
            "access_token": apiKey,
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
//            print(response.value ?? "")
        }
    }
    
    func loadPhotoData(userId: String){
        let path = "/method/photos.get"
        let methodName: Parameters = [
            "owner_id": userId,
            "album_id": "wall",
            "access_token": apiKey,
            "v": "5.130"
        ]

        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
//            print(response.value ?? "")
        }
    }

    func loadNewsVKData(userPath: String, completion: @escaping ([NewsVK]) -> Void  ) {
        
        let path = "/method/newsfeed.get"
        let methodName: Parameters = [
            "filters": "post",
            "start_from": "next_from",
            "count": "25",
            "access_token": apiKey,
            "v": "5.103"
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseData { response in
            guard let data = response.value else { return }
            if let newsArray = try? JSONDecoder().decode(NewsVKResponce.self, from: data) {
                completion(newsArray.response.items)
            } else {
                print("Error")
            }
//            newsArray.response.items.forEach { print( $0.postID )}
        }
    }
    
    func searchGroups(searchField: String){
        let path = "/method/groups.search"
        let methodName: Parameters = [
            "q": searchField,
            "count": "3",
            "access_token": apiKey,
            "v": "5.130",
            "fields": "photo_50"
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
//            print(response.value ?? "")
        }
    }
    
    func friendVK(userPath: String, completion: @escaping ([FriendsVK]) -> Void){
        let path = "/method/" + userPath
        let methodName: Parameters = [
            "q": userPath,
            "count": "10",
            "access_token": apiKey,
            "v": "5.130",
            "fields": "photo_50"
        ]

        let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseData { response in
            guard let data = response.value else { return }
//            let userArray = try! JSONDecoder().decode(FriendsResponce.self, from: data)
            guard let userArray = try? JSONDecoder().decode(FriendsResponce.self, from: data) else {return}

//            userArray.response.items.forEach { print($0.friendInfo = userPath) }
            completion(userArray.response.items)
        }
    }
    
    // Promise
//    func getFriendsPromise(userPath: String) -> Promise<[FriendsVK]> {
//        let path = "/method/" + userPath
//        
//        let params: Parameters = [
//            "q": userPath,
//            "count": "10",
//            "access_token": apiKey,
//            "v": "5.130",
//            "fields": "photo_50"
//        ]
//        
//        let url = baseUrl+path
//        
//        let promise = Promise<[FriendsVK]> { resolver in
//            AF.request(url, method: .get, parameters: params).responseJSON { response in
//            
//                switch response.result {
//                case let .success(json):
//                    
//                    guard let data = response.value else { return }
//                    let userArray = try! JSONDecoder().decode(FriendsResponce.self, from: data)
//
//                    resolver.fulfill(userArray.response.items)
//                    
//                    case let .failure(error):
//                    resolver.reject(error)
// 
//                }
//            }
//        }
//         return promise
//    }
    
    // Promise 2

//    func getFriendsPromise2(userPath: String) -> Promise<[FriendsVK]> {
//        let path = "/method/" + userPath
//
//        let params: Parameters = [
//            "q": userPath,
//            "count": "10",
//            "access_token": apiKey,
//            "v": "5.130",
//            "fields": "photo_50"
//        ]
//
//        let url = baseUrl+path
//
//        return Promise { resolver in
//            AF.request(url, method: .get, parameters: params).responseJSON { response in
//                switch response.result {
//                case let .success(json):
//                    let friends = FriendsVK(JSON(json), Friends: Friends)
//                    resolver.fulfill(friends)
//                case let .failure(error):
//                resolver.reject(error)
//                }
//        }
//    }
//}

    
    func groupVK(userPath: String, completion: @escaping ([GroupVK]) -> Void){
        let path = "/method/" + userPath
        let methodName: Parameters = [
            "q": userPath,
            "count": "10",
            "access_token": apiKey,
            "v": "5.130",
            "fields": "photo_604",
            "user_id": 29839817,
            "extended": 1
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseData { response in
            guard let data = response.value else { return }
            
//            let userArray = try! JSONDecoder().decode(GroupssResponce.self, from: data)
            guard let userArray = try? JSONDecoder().decode(GroupssResponce.self, from: data) else { return }
            completion(userArray.response.items)
        }
    }

    func photoVK(userPath: String, completion: @escaping ([PhotoVK]) -> Void){
        let path = "/method/" + userPath
        let methodName: Parameters = [
            
            "owner_id": 29839817,
            "album_id": "wall",
            "access_token": apiKey,
            "v": "5.130"
            
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseData { response in
            guard let data = response.value else { return }
//            let userArray = try! JSONDecoder().decode(PhotosResponce.self, from: data)
            guard let userArray = try? JSONDecoder().decode(PhotosResponce.self, from: data) else { return }
            
//            userArray.response.items.forEach{ print($0.photoInfo = userPath)}
            completion(userArray.response.items)
        }
    }
    
    
    
    func newsRequest(startFrom: String = "",
                  startTime: Double? = nil,
                  completion: @escaping (Swift.Result<[NewsVK], Error>, String) -> Void) {
       
        let path = "/method/newsfeed.get"
        var params: Parameters = [
            "access_token": Sessions.shared.token,
            "filters": "post",
            "v": "5.87",
            "count": "20",
            "start_from": startFrom
        ]
       
        if let startTime = startTime {
            params["start_time"] = startTime
        }
       
//        AF.request(baseUrl + path, method: .get, parameters: params).responseJSON(queue: .global()) { response in
//            switch response.result {
//            case .failure(let error):
//                completion(.failure(error), "")
//            case .success(let value):
//                let json = JSON(value)
//                var friends = [FriendsVK]()
//                var groups = [GroupVK]()
//                let nextFrom = json["response"]["next_from"].stringValue
//
//                let parsingGroup = DispatchGroup()
//                DispatchQueue.global().async(group: parsingGroup) {
//                    friends = json["response"]["friends"].arrayValue.map { FriendsVK(from: $0) }
//                }
//                DispatchQueue.global().async(group: parsingGroup) {
//                    groups = json["response"]["groups"].arrayValue.map { GroupVK(from: $0) }
//                }
//                parsingGroup.notify(queue: .global()) {
//                    let news = json["response"]["news"].arrayValue.map { NewsVK(from: $0) }
//
//                    news.forEach { newsItem in
//                        if newsItem.sourceId > 0 {
//                            let source = friends.first(where: { $0.id == newsItem.sourceId })
//                            newsItem.source = source
//                        } else {
//                            let source = groups.first(where: { $0.id == -newsItem.sourceId })
//                            newsItem.source = source
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        completion(.success(news), nextFrom)
//                    }
//                }
//            }
//        }
    }

}




