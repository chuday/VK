//
//  ImageFriendViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 11.03.2021.
//

import UIKit


class ImageFriendViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    var friend: User?
    var selectedIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ImageFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend?.usersPhoto.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageFriendCollectionViewCell
       
        let photo = friend?.usersPhoto[indexPath.row]
        cell.imageFriend.image = UIImage(named: photo!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SwipeImage {
            destination.selectedIndex = selectedIndex
            destination.usersPhoto = (friend?.usersPhoto)!
        }
    }
}
