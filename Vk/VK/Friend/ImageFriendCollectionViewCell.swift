//
//  ImageFriendCollectionViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 11.03.2021.
//

import UIKit

class ImageFriendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
    }
}
