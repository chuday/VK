//
//  ImageFriendViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 11.03.2021.
//

import UIKit

struct FriendInfo {
    var name: String
    var image: UIImage
}

class ImageFriendViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var friend = [FriendInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friend = [
        FriendInfo(name: "Photo 1", image: #imageLiteral(resourceName: "f2")),
        FriendInfo(name: "Photo 2", image: #imageLiteral(resourceName: "f5")),
        FriendInfo(name: "Photo 3", image: #imageLiteral(resourceName: "f3")),
        FriendInfo(name: "Photo 4", image: #imageLiteral(resourceName: "f4"))
        ]
    }
}

extension ImageFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageFriendCollectionViewCell
        let friends = friend[indexPath.item]
        cell.nameLabel.text = "\(friends.name)"
        cell.imageFriend.image = friends.image
    
        return cell
    }
}
