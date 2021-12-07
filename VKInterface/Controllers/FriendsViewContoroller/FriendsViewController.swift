//
//  FriendsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
//  @IBOutlet weak var searchFriendsBar: UISearchBar!
  
  let cellReuseIdentificator = "cellReuseIdentificator"

  let toGallerySeague = "toGallerySeague"
  
  var friendsArray = [Friends]()
  
//  var filteredData: [Friends]!

  
  func fillFriendsData() {
    let friendOne = Friends(name: "Вася",
                          surname: "Попов",
                          avatar: "bartAvatar",
                          photoGallery: ["homer", "lisa", "bart", "all", "homer2"])
    let friendTwo = Friends(name: "Мария",
                          surname: "Петрова",
                          avatar: nil,
                          photoGallery: ["fg1", "fg2","fg3", "fg4", "fg5"])
    let friendThree = Friends(name: "Инокентий",
                          surname: nil,
                          avatar: "dipperAvatar",
                          photoGallery: ["gf1", "gf2", "gf3", "gf4", "gf5"])
    friendsArray.append(friendOne)
    friendsArray.append(friendTwo)
    friendsArray.append(friendThree)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    searchFriendsBar.delegate = self
//    filteredData = friendsArray
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    fillFriendsData()
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(addNewUser(_ :)),
                                           name:
                                            Notification.Name("addNewUserButton"),
                                           object: nil)
    tableView.reloadData()
  }
  
  @objc func addNewUser (_ notification: Notification) {
    
    guard let groupObject = notification.object as? Friends else { return }
    
    friendsArray.append(groupObject)
    tableView.reloadData()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}


