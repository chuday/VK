//
//  NetworkManager.swift
//  VK
//
//  Created by Михаил Чудаев on 21.04.2021.


import Foundation
import Alamofire
import AlamofireImage
import  RealmSwift

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
        
    func friendMapp(userPath: String, completion: @escaping ([FriendsMap]) -> Void){
            let path = "/method/" + userPath
            let methodName: Parameters = [
                "q": userPath,
                "count": "10",
                "access_token": apiKey,
                "v": "5.130",
                "fields": "photo_50"
            ]

            let url = baseUrl+path
        
        AF.request(url, method: .get, parameters: methodName).responseData { [ weak self ] response in
                guard let data = response.value else { return }
            let userArray = try! JSONDecoder().decode(FriendsResponce.self, from: data)
            self?.clearFriendsData()
            self?.saveFriendData(userArray.response.items)
            completion(userArray.response.items)
            }
            
        }
    
    func clearFriendsData() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print(error)
        }

    }
    
    func saveFriendData(_ friends: [FriendsMap]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(friends)
            }
        } catch {
            print(error)
        }
    }
    
    
    func groupMapp(userPath: String, completion: @escaping ([GroupMapp]) -> Void){
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
    
    func saveGroupData(_ group: [GroupMapp]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(group)
            }
        } catch {
            print(error)
        }
    }
    
    
    func photoMapp(userPath: String, completion: @escaping ([PhotoMapp]) -> Void){
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
            let userArray = try! JSONDecoder().decode(PhotosResponce.self, from: data)
            completion(userArray.response.items)
            }
            
        }
    
  
    
    
    
}



                
