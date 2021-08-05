//
//  MyView.swift
//  VK
//
//  Created by Михаил Чудаев on 14.03.2021.
//

import UIKit

//@IBDesignable
class MyView: UIView {
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 5  {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var image: UIImage? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let imageView = UIImageView()
        imageView.image = image
        imageView.frame = layer.bounds
        imageView.layer.borderColor = borderColor.cgColor
        imageView.layer.borderWidth = borderWidth
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        self.addSubview(imageView)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = shadowOffset
    }
}

