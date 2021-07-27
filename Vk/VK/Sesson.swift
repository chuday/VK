//
//  Sesson.swift
//  VK
//
//  Created by Михаил Чудаев on 14.04.2021.
//

import UIKit

class Session {
    
    static let instance = Session()
    
    private init(){}
    
    var token = ""
    var userId = 0
}
