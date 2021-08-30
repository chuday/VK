//
//  NewsTableViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit

protocol NewsTableViewCellDelegate: Any {
    func didTap(cell: NewsTableViewCell, item: NewsVK)
}

class NewsTableViewCell: UITableViewCell {
    
     var delegate: NewsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let margins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    static func heightOfElements() -> CGFloat {
        margins.top + margins.bottom
    }
    
    static let defaultTextHeight: CGFloat = 200
    
    @IBOutlet weak var avtorLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var textNews: UILabel!
    @IBOutlet weak var imageAvtor: UIImageView!
    @IBOutlet weak var imageNews: UIImageView!
    
    @IBOutlet weak var like: LikeButton!
    @IBOutlet weak var comment: CommentButton!
    @IBOutlet weak var share: ShareButton!
    
    static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    func configure(newsVK: NewsVK) {
        
        let date = Date(timeIntervalSince1970: newsVK.date)
        let stringDate = NewsTableViewCell.dateFormatter.string(from: date)
        
        dataLabel.text = stringDate
        like.likeCount = newsVK.likes.count
        
//        if newsVK.textHeight < NewsTableViewCell.defaultTextHeight || newsVK.isExpandet {
//            textNews.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: newsVK.textHeight)
//        } else {
//            textNews.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: NewsTableViewCell.defaultTextHeight)
//        }
    }
    
    // для кнопки разворота
    func didTapShow() {
//        delegate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avtorLabel.text = ""
        dataLabel.text = ""
        textNews.text = ""
        imageView?.image = nil
    }
    
}
