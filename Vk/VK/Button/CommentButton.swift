//
//  CommentButton.swift
//  VK
//
//  Created by Михаил Чудаев on 27.03.2021.
//

import UIKit


//@IBDesignable
class CommentButton: UIControl {
    
    @IBInspectable var comment: String = "" {
        didSet {
            updateLabelText()
        }
    }
    
    private var stackView: UIStackView!
    private var commentLabel: UILabel!
    
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
        stackView = UIStackView(arrangedSubviews: [commentLabel])
        addSubview(stackView)
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        updateSelectionState()
    }
    
    private func updateLabelText() {
        commentLabel.text = "comment"
        
    }
    
    private func updateSelectionState() {
        let color = isSelected ? tintColor : .black
        commentLabel.textColor = color
        updateLabelText()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSelected = !isSelected
        updateSelectionState()
        sendActions(for: .valueChanged)
        textCommentChange()
        
    }
    
    func textCommentChange() {
        UIView.transition(with: commentLabel, duration: 0.5, options: [.transitionCrossDissolve]) { self.commentLabel.text = "change"}
    }
}
