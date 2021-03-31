//
//  GroupTableViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 10.03.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}
