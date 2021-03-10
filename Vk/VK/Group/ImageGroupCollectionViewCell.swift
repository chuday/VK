//
//  ImageGroupCollectionViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 10.03.2021.
//

import UIKit

class ImageGroupCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        infoLabel.text = ""
    }
}
