//
//  SwipeImage.swift
//  VK
//
//  Created by Михаил Чудаев on 02.04.2021.
//

import UIKit

class SwipeImage: UIViewController {
    
    var usersPhoto:  [PhotoVK] = []
    //    var usersPhoto: [String] = []
    var selectedIndex: Int = 0
    
    
    @IBOutlet weak var detailPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailPhoto.af.setImage(withURL: URL(string: usersPhoto[selectedIndex].sizes.last?.url ?? "")!)
        //        detailPhoto.image = UIImage(named: usersPhoto[selectedIndex])
        detailPhoto.backgroundColor = view.backgroundColor
        let swipeLeft = UISwipeGestureRecognizer (target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer (target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeftAction() {
        guard usersPhoto.count > selectedIndex + 1 else {return}
        let newTempImgView = UIImageView ()
        
        newTempImgView.af.setImage(withURL: URL(string: usersPhoto[selectedIndex + 1].sizes.last?.url ?? "")!)
        //        let nextImage = UIImage(named: usersPhoto [selectedIndex + 1])
        newTempImgView.backgroundColor = view.backgroundColor
        newTempImgView.contentMode = .scaleAspectFit
        //        newTempImgView.image = nextImage
        newTempImgView.frame = detailPhoto.frame
        newTempImgView.frame.origin.x += detailPhoto.frame.maxX
        view.addSubview(newTempImgView)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.detailPhoto.transform = CGAffineTransform (scaleX: 0.8, y: 0.8)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                newTempImgView.frame.origin.x = 0
            }
        } completion: { _ in
            self.detailPhoto.af.setImage(withURL: URL(string: self.usersPhoto[self.selectedIndex + 1].sizes.last?.url ?? "")!)
            
            //            self.detailPhoto.image = nextImage
            self.detailPhoto.transform = .identity
            newTempImgView.removeFromSuperview()
            self.selectedIndex += 1
        }
        
    }
    @objc func swipeRightAction() {
        guard selectedIndex - 1 >= 0 else {return}
        //        let nextImage = UIImage(named: usersPhoto [selectedIndex - 1])
        let newTempImgView = UIImageView ()
        newTempImgView.af.setImage(withURL: URL(string: usersPhoto[selectedIndex - 1].sizes.last?.url ?? "")!)
        
        newTempImgView.backgroundColor = view.backgroundColor
        newTempImgView.contentMode = .scaleAspectFit
        //        newTempImgView.image = nextImage
        newTempImgView.frame = detailPhoto.frame
        newTempImgView.transform = CGAffineTransform (scaleX: 0.8, y: 0.8)
        view.addSubview(newTempImgView)
        view.sendSubviewToBack(newTempImgView)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.detailPhoto.transform = CGAffineTransform (translationX: self.view.bounds.width, y: 0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                newTempImgView.transform = .identity
            }
        } completion: { _ in
            self.detailPhoto.af.setImage(withURL: URL(string: self.usersPhoto[self.selectedIndex - 1].sizes.last?.url ?? "")!)
            
            //            self.detailPhoto.image = nextImage
            self.detailPhoto.transform = .identity
            newTempImgView.removeFromSuperview()
            self.selectedIndex -= 1
        }
    }
}
