//
//  FriendImageViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 15.08.2021.
//

import UIKit

struct FriendData {
    var name: String
    var info: String
    var image: UIImage!
}


class FriendImageViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var imagesGroup = [FriendData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesGroup = [
            FriendData(name: "people", info: "different people", image: (#imageLiteral(resourceName: "f8"))),
            FriendData(name: "animals", info: "dog", image: (#imageLiteral(resourceName: "f5"))),
            FriendData(name: "sport", info: "fitness", image: (#imageLiteral(resourceName: "f4"))),
            FriendData(name: "car", info: "baggi", image: (#imageLiteral(resourceName: "f10")))
        ]
    }
}

extension FriendImageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell2", for: indexPath) as! FriendImageCollectionViewCell
        let imagesGroups = imagesGroup[indexPath.item]
        cell.nameFriendLabel?.text = "\(imagesGroups.info)"
        cell.friendInfoLabel?.text = imagesGroups.name
        cell.imageFriend?.image = imagesGroups.image
        
//        cell.setNameFriends(text: imagesGroups.info)
//        cell.setFriendsInfo(text: imagesGroups.name)
        
        return cell
    }
}
