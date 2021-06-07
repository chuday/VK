//
//  NetworkManager.swift
//  VK
//
//  Created by Михаил Чудаев on 21.04.2021.


import Foundation
import Alamofire
import AlamofireImage
import RealmSwift

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
            print(response.value ?? "")
        }
    }
    
    func loadUserData(data: String, userId: String){
        let path = "/method/" + data
        let methodName: Parameters = [
            "user_ids": userId,
            "fields": "bdate",
            "access_token": apiKey,
            "v": "5.130"
        ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
            print(response.value ?? "")
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
            print(response.value ?? "")
        }
    }
    
    
    /////////////// ///
    func loadNewsVKData(userPath: String ) {
        let path = "/method/newsfeed.get"
        let methodName: Parameters = [
            "filters": "post",
            "start_from": "next_from",
            "count": "3",
            "access_token": apiKey,
            "v": "5.103"
            ]
        
        let url = baseUrl+path
        AF.request(url, method: .get, parameters: methodName).responseJSON { response in
            print(response.value ?? "")
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
            print(response.value ?? "")
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
        
        // 6
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(FriendsResponce.self, from: data)
            userArray.response.items.forEach { $0.friendInfo = userPath }
            //            self?.clearFriendsData()
            self?.saveFriendData(userArray.response.items, friendInfo: userPath)
            completion(userArray.response.items)
        }
    }
    
    // 6
    func saveFriendData(_ friends: [FriendsVK], friendInfo: String) {
        do {
            let realm = try Realm()
            let oldFriends = realm.objects(FriendsVK.self).filter("friendInfo ==%@", friendInfo)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
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
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(GroupssResponce.self, from: data)
            self?.clearGroupData()
            self?.saveGroupData(userArray.response.items)
            completion(userArray.response.items)
        }
    }
    
    func clearGroupData() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupData(_ group: [GroupVK]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(group)
            }
        } catch {
            print(error)
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
        
        // 6
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
            guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(PhotosResponce.self, from: data)
            
            userArray.response.items.forEach{ $0.photoInfo = userPath}
            //            self?.savePhotoData(userArray.response.items, photoInfo: userPath)
            completion(userArray.response.items)
        }
    }
    
    //    func savePhotoData(_ photo: [PhotoVK], photoInfo: String) {
    //        do {
    //            let realm = try Realm()
    //            let oldPhoto = realm.objects(PhotoVK.self).filter("photoInfo ==%@", photoInfo)
    //            realm.beginWrite()
    //            realm.delete(oldPhoto)
    //            realm.add(photo)
    //            try realm.commitWrite()
    //        } catch {
    //            print(error)
    //        }
    //    }
}




