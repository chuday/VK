//
//  NetworkManager.swift
//  VK
//
//  Created by Михаил Чудаев on 21.04.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let session: URLSession = {
       let configuration = URLSessionConfiguration.default
        
        return URLSession(configuration: configuration )
    }()
    
    private init() { }

    func getDataVK(token: String) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "http"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "client_id", value: "7831130"),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "v", value: "5.130")
        ]

                let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    print("JSON\(json)")
                }
                task.resume()
    }
}
