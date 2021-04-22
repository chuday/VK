//
//  FriendsTableViewHeader.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit

class FriendsTableViewHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        let view = UIView()
        
        let view = GradientView()
        view.colorStart = .green
        view.colorEnd = .opaqueSeparator
        view.startPoint = .init(x: 0, y: 0)
        view.endPoint = .init(x: 0, y: 1)
        
        backgroundView = view
        self.backgroundView?.layer.opacity = 0.3
        
        
    }
    
    func configure(text:String) {
        titleLabel.text = text
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
