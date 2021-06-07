//
//  ImageFriendViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 11.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift


class ImageFriendViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var friend: User?
    var selectedIndex = 0
    var photoVK: [PhotoVK] = []
    
    // 6
    var photo: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.photoVK(userPath: "photos.get") { [weak self] photoData in
            DispatchQueue.main.async {
                self?.photoVK = photoData
                self?.collectionView.reloadData()
                print("Photo array: \(self?.photoVK.map { $0.ownerId }) ")
                
            }
        }
        // 6
        //        loadPhotoDataFromRealm()
        ////        let cachedFriend = loadDataFromRealm()
        ////        if cachedFriend.isEmpty {
        //        collectionView.reloadData()
        //        NetworkManager.shared.friendVK(userPath: "photos.get") { [weak self] _ in
        //            DispatchQueue.main.async {
        ////                self?.friendsMap = friendData
        //                self?.loadPhotoDataFromRealm()
        ////                self?.tableView.reloadData()
        ////                print("Friends array: \(self?.friendsVK.map { $0.firstName + " " + $0.lastName }) ")
        //                    }
        //                }
    }
    
    // 6
    //    func loadPhotoDataFromRealm() {
    //        do {
    //            let realm = try Realm()
    //            print(realm.configuration.fileURL)
    //            let photo = realm.objects(PhotoVK.self)
    //            self.photoMapp = Array(photo)
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //        self.collectionView.reloadData()
    //
    //    }
}


extension ImageFriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoVK.count
        //        return friend?.usersPhoto.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageFriendCollectionViewCell
        
        let photo = photoVK[indexPath.row]
        //        let photo = friend?.usersPhoto[indexPath.row]
        cell.imageFriend.af.setImage(withURL: URL(string: photo.sizes.last?.url ?? "")!)
        //        cell.imageFriend.image = UIImage(named: photo!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SwipeImage {
            destination.selectedIndex = selectedIndex
            destination.usersPhoto = photoVK
            //            destination.usersPhoto = (friend?.usersPhoto)!
        }
    }
}
