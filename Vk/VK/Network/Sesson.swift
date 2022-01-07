//
//  Sesson.swift
//  VK
//
//  Created by Михаил Чудаев on 14.04.2021.
//
import UIKit

class Sessions {
    
    static let shared = Sessions()
    private init(){}
    
    var token = ""
    var userId = 0
}
