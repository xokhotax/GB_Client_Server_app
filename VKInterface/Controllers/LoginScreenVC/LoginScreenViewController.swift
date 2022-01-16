//
//  LoginScreenViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 14.11.2021.
//

import UIKit

class LoginScreenViewController: UIViewController {
  
  @IBOutlet weak var loginTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginTitle: NSLayoutConstraint!
  @IBOutlet weak var welcomeTitle: UILabel!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var popUpMessage: UIView!
  
  let toWelcomePage = "fromLoginScreenToWelcomePage"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(onPressed),
                                           name:
                                            Notification.Name("loginButton"),
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(keyboardDidShow(_:)),
                                           name:
                                            UIResponder.keyboardDidShowNotification,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(keyboardDidShow(_:)),
                                           name:
                                            UIResponder.keyboardDidHideNotification,
                                           object: nil)
    
    let recognizer = UITapGestureRecognizer(target: self,
                                            action: #selector(onTap(_:)))
    recognizer.cancelsTouchesInView = false
    self.view.addGestureRecognizer(recognizer)
    
  }
  
  @objc func onPressed () {
  
    performSegue(withIdentifier: "fromLoginScreenToWelcomePage",
                 sender: nil)
  }
  
  
  @objc func onTap (_ recognizer: UITapGestureRecognizer) {
    self.view.endEditing(true)
  }
  
  
  @objc func keyboardDidShow(_ notification: Notification) {
    
    let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey]
                        as? NSValue)?.cgRectValue
    guard let keyboardHeight = keyboardSize?.height else {return}
    
    let contentInsets = UIEdgeInsets(top: 0,
                                     left: 0,
                                     bottom: keyboardHeight + 18,
                                     right: 0)
    
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
  }
  
  @objc func keyboardDidHide(_ notification: Notification) {
    let contentInsets = UIEdgeInsets.zero
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @IBAction func loginButton(_ sender: Any) {
    
    NotificationCenter.default.post(name: Notification.Name("loginButton"),
                                    object: nil)

    self.view.endEditing(true)
  }
}
