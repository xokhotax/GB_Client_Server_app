//
//  AddFriendViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

class AddFriendViewController: UIViewController {
  
  
  @IBOutlet weak var addFriendScrollView: UIScrollView!
  @IBOutlet weak var newUserName: UITextField!
  @IBOutlet weak var newUserSurname: UITextField!
  
  private let realm = try? Realm()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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
    
    addFriendScrollView.contentInset = contentInsets
    addFriendScrollView.scrollIndicatorInsets = contentInsets
  }
  
  @objc func keyboardDidHide(_ notification: Notification) {
    let contentInsets = UIEdgeInsets.zero
    addFriendScrollView.contentInset = contentInsets
    addFriendScrollView.scrollIndicatorInsets = contentInsets
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  @IBAction func addNewUser(_ sender: Any) {
    
    addNewFriend()
    
    //    NotificationCenter.default.post(name: Notification.Name("addNewUserButton"),
    //                                    object: newAddFriendData)
    
    self.view.endEditing(true)
  }
  
  func addNewFriend() {
    do {
      guard let newUserName = newUserName.text,
            let newUserSurname = newUserSurname.text
      else { return }
      let friend = Friends()
      friend.firstName = newUserName
      friend.lastName = newUserSurname
      friend.friendId = String(Int.random(in: 1..<1000000))
      try realm?.write({
        self.realm?.add(friend)
      })
    } catch {
      print(error)
    }
  }
  
  
}
