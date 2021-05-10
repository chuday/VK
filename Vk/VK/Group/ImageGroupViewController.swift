//
//  ImageGroupViewController.swift
//  VK
//
//  Created by Михаил Чудаев on 10.03.2021.
//

import UIKit

struct ImageData {
    var name: String
    var info: String
}

class ImageGroupViewController: UIViewController {
  
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    var imagesGroup = [ImageData]()

    override func viewDidLoad() {
        super.viewDidLoad()        
        imagesGroup = [
            ImageData(name: "people", info: "different people"),
            ImageData(name: "animals", info: "dog"),
            ImageData(name: "sport", info: "fitness"),
            ImageData(name: "car", info: "baggi")
        ]
    }
}

extension ImageGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageGroupCollectionViewCell
        let imagesGroups = imagesGroup[indexPath.item]
        cell.nameLabel.text = "\(imagesGroups.info)"
        cell.infoLabel.text = imagesGroups.name
        return cell
    }
}
