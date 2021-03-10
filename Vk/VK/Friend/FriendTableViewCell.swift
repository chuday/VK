//
//  FriendTableViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 10.03.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}
