//
//  ShareButton.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit


@IBDesignable class ShareButton: UIControl {
    
    @IBInspectable var share: String = "" {
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
    private var shareLabel: UILabel!
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
        shareLabel = UILabel()
        likeImageView = UIImageView()
        likeImageView.contentMode = .scaleAspectFit
        shareLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [shareLabel, likeImageView])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
//        let additionalLike = isSelected ? 1 : 0
        shareLabel.text = "\(share)"
        
    }
    
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        shareLabel.textColor = color
        likeImageView.tintColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        sendActions(for: .valueChanged)
    }
    
}
