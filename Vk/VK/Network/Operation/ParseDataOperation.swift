//
//  ParseDataOperation.swift
//  VK
//
//  Created by Михаил Чудаев on 05.08.2021.
//

import Foundation

struct Post {
    let id: Int
    let title: String
    let body: String
}

class ParseDataOperation: Operation {
    
    var outputData: [Post] = []
    override func main() {
        guard let getDataOperation = dependencies.first as? GetDataOperation,
              let data = getDataOperation.data else { return }
          }
    
}
