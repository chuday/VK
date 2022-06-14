//
//  FriendImageCollectionViewCell.swift
//  VK
//
//  Created by Михаил Чудаев on 15.08.2021.
//

import UIKit


class FriendImageCollectionViewCell: UICollectionViewCell {

//    @IBOutlet weak var friendInfoLabel: UILabel!
//    @IBOutlet weak var nameFriendLabel: UILabel!
//    @IBOutlet weak var imageFriend: UIImageView!
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    


    @IBOutlet  var friendInfoLabel: UILabel! {
        didSet {
            friendInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var nameFriendLabel: UILabel! {
        didSet {
            nameFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    @IBOutlet weak var imageFriend: UIImageView! {
        didSet {
            imageFriend.translatesAutoresizingMaskIntoConstraints = false
        }
    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        nameFriendLabel.text = ""
//        friendInfoLabel.text = ""
//    }
//}

    let instets: CGFloat = 10.0

    func setFriendsInfo(text: String) {
            friendInfoLabel.text = text
            infoLabelFrame()
    }
    deinit {
        print("")
    }

    func setNameFriends(text: String) {
        nameFriendLabel.text = text
        nameLabelFrame()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        infoLabelFrame()
//        nameLabelFrame()
//        imageFrame()
    }

    func getLabelSize(text: String?, font: UIFont) -> CGSize {

        guard let text = text else { return .zero}
        //определяем максимальную ширину, которую может занимать наш текст

        //это ширина ячейки минус отступы слева и справа
        let maxWidth = bounds.width - instets * 2

        //получаем размеры блока, в который надо вписать надпись //используем максимальную ширину и максимально возможную высоту
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)

        //получим прямоугольник, который займёт наш текст в этом блоке, уточняем, каким шрифтом он будет написан
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        //получаем ширину блока, переводим ее в Double
        let width = Double(rect.size.width)

        //получаем высоту блока, переводим ее в Double
        let height = Double(rect.size.height)

        //получаем размер, при этом округляем значения до большего целого числа
        let size = CGSize(width: ceil(width), height: ceil(height))

        return size
    }

        func infoLabelFrame() {

        //получаем размер текста, передавая сам текст и шрифт.
            let friendsInfoLabelSize = getLabelSize(text: friendInfoLabel.text, font: friendInfoLabel.font)


                //рассчитывает координату по оси Х
        let friendInfoLabelX = (bounds.width - friendsInfoLabelSize.width) / 2 //получим точку верхнего левого угла надписи
        let friendInfoLabelOrigin = CGPoint(x: friendInfoLabelX, y: instets) //получаем фрейм и устанавливаем UILabel
            friendInfoLabel.frame = CGRect(origin: friendInfoLabelOrigin, size: friendsInfoLabelSize)
        }


        func nameLabelFrame() {

        //получаем размер текста, передавая сам текст и шрифт.
        let nameLabelSize = getLabelSize(text: nameFriendLabel.text!, font: nameFriendLabel.font)

                //рассчитывает координату по оси Х
        let nameLabelX = (bounds.width - nameLabelSize.width) / 2 //рассчитывает координату по оси Y
        let nameLabelY = bounds.height - nameLabelSize.height - instets //получим точку верхнего левого угла надписи
        let nameLabelOrigin = CGPoint(x: nameLabelX, y: nameLabelY) //получаем фрейм и устанавливаем UILabel
            nameFriendLabel.frame = CGRect(origin: nameLabelOrigin, size: nameLabelSize)
        }


        func imageFrame() {
                let imageSideLinght: CGFloat = 50
                let imageSize = CGSize(width: imageSideLinght, height: imageSideLinght)
                let imageOrigin = CGPoint(x: bounds.midX - imageSideLinght / 2, y: bounds.midY - imageSideLinght / 2)
                imageFriend.frame = CGRect(origin: imageOrigin, size: imageSize)
            }
    }

