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
    

    
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    func configure(newsVK: NewsVK) {
        
        let date = Date(timeIntervalSince1970: newsVK.date)
        let stringDate = NewsTableViewCell.dateFormatter.string(from: date)
        
        dataLabel.text = stringDate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avtorLabel.text = ""
        dataLabel.text = ""
        textNews.text = ""
        imageView?.image = nil
    }
    
    
}
