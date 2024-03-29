//
//  NewsTableViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var avtorLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageAvtor: UIImageView!
    @IBOutlet weak var imageNews: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        avtorLabel.text = ""
        dataLabel.text = ""
        textNews.text = ""
        imageView?.image = nil
    }
}
