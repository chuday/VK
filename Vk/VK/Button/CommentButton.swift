//
//  CommentButton.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit


@IBDesignable class CommentButton: UIControl {
    
    @IBInspectable var comment: String = "" {
        didSet {
          updateLabelText()
        }
    }
    
//    @IBInspectable var likeImage: UIImage? = nil {
//        didSet {
//            likeImageView.image = likeImage
//        }
//    }
  
    private var stackView: UIStackView!
    private var commentLabel: UILabel!
//    private var likeImageView: UIImageView!
    
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
        commentLabel = UILabel()
//        likeImageView = UIImageView()
//        likeImageView.contentMode = .scaleAspectFit
//        countLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [commentLabel])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
//        let additionalLike = isSelected ? 1 : 0
        commentLabel.text = "comment"
        
    }
    
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        commentLabel.textColor = color
//        likeImageView.tintColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        sendActions(for: .valueChanged)
    }
    
}
