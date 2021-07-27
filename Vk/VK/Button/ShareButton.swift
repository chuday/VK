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
    
    @IBInspectable var shareImage: UIImage? = nil {
        didSet {
            shareImageView.image = shareImage
        }
    }
  
    private var stackView: UIStackView!
    private var shareLabel: UILabel!
    private var shareImageView: UIImageView!
    
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
        shareImageView = UIImageView()
        shareImageView.contentMode = .scaleAspectFit
        shareLabel.textAlignment = .left
        stackView = UIStackView(arrangedSubviews: [shareLabel, shareImageView])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
        shareLabel.text = "\(share)"
        
    }
    
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        shareLabel.textColor = color
        shareImageView.tintColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        sendActions(for: .valueChanged)
    }
    
}
