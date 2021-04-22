//
//  LikeButton.swift
//  VK
//
//  Created by Михаил Чудаев on 17.03.2021.
//

import UIKit

@IBDesignable class LikeButton: UIControl {
    
    @IBInspectable var likeCount: Int = 0 {
        didSet {
          updateLabelText()
        }
    }
    
    @IBInspectable var likeImage: UIImage? = nil {
        didSet {
            likeImageView.image = likeImage
        }
    }
  
    private var stackView: UIStackView!
    private var countLabel: UILabel!
    private var likeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func commonInit() {
        countLabel = UILabel()
        likeImageView = UIImageView()
        likeImageView.contentMode = .scaleAspectFit
        countLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [countLabel, likeImageView])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
        let additionalLike = isSelected ? 1 : 0
        countLabel.text = "\(likeCount + additionalLike)"
        
    }
    
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        countLabel.textColor = color
        likeImageView.tintColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        sendActions(for: .valueChanged)
    }
    
}
