//
//  MyImageView.swift
//  VK
//
//  Created by Михаил Чудаев on 16.03.2021.
//

import UIKit

@IBDesignable class MyImageView: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.masksToBounds = cornerRadius > 0
            layer.cornerRadius = cornerRadius
        }
    }
}
