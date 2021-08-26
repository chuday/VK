//
//  ReloadTableController.swift
//  VK
//
//  Created by Михаил Чудаев on 23.08.2021.
//

import Foundation
import UIKit

class ReloadTableController: Operation {
    var controller: TableController
    
    init(controller: TableController) {
        self.controller = controller
}
override func main() {
guard let parseData = dependencies.first as? ParseDataOperation else { return }
    controller.posts = parseData.outputData
    controller.reloadData()
}
    
}
