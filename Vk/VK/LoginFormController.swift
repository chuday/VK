//
//  LoginFormController.swift
//  VK
//
//  Created by Михаил Чудаев on 28.02.2021.
//

import UIKit

class LoginFormController: UIViewController {
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var passwordEye: UIButton!
    
    @IBOutlet weak var viewTarinsition: UIView!
    
    @IBOutlet weak var loadOne: UILabel!
    @IBOutlet weak var loadTwo: UILabel!
    @IBOutlet weak var loadTree: UILabel!
    
    
    @IBAction func passwordEye(_ sender: Any) {
        passwordInput.isSecureTextEntry = false
        passwordEye.tintColor = .darkGray
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.passwordInput.isSecureTextEntry = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text?.lowercased(),
              let password = passwordInput.text?.lowercased() else { return false }
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Ошибка", message: "Некорректный ввод", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if checkUserData() {return true}
        showLoginError()
        return false
    }
    
    @IBAction func buttonPress() {
        
        // первый способ
        loadScreen()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
            self.performSegue(withIdentifier: "to", sender: self)
        }
        
        // второй способ
        //        UIView.animate(withDuration: 0.5, delay: 3, options: []) {
        //            self.loadScreen()
        //            self.passwordEye.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        //
        //        } completion: { completed in
        //            self.performSegue(withIdentifier: "to", sender: self)
        //        }
    }
    
    
    func loadScreen() {
        UIView.animate(withDuration: 0.5, delay: 0.2, options: [.autoreverse, .repeat]) {
            self.loadOne.alpha = 1
        } completion: { success in
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [.autoreverse, .repeat]) {
            self.loadTwo.alpha = 1
        } completion: { success in
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [.autoreverse, .repeat]) {
            self.loadTree.alpha = 1
        } completion: { success in
            
        }
    }
    
    func settingLoad() {
        loadOne.layer.masksToBounds = true
        loadOne.layer.cornerRadius = 10
        loadOne.alpha = 0
        loadTwo.layer.masksToBounds = true
        loadTwo.layer.cornerRadius = 10
        loadTwo.alpha = 0
        loadTree.layer.masksToBounds = true
        loadTree.layer.cornerRadius = 10
        loadTree.alpha = 0
    }
}
