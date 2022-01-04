//
//  FriendsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import Alamofire


class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarFriend: UISearchBar!
  
  weak var delegate: FriendsDataLoad?
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let toGallerySeague = "toGallerySeague"
  var friendsArray = [Friends]()
  var usersArray: [UsersListResponse] = []
  private let networkServices = NetworkServices()
  
  
  
  ////    let friendsData = FriendsData.shared.sourceFriendsArray
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    FriendsData.shared.delegate = self
    
    networkServices.vkFriendsList()  { response in
      self.usersArray = [response]
      print("Финальный массив \(self.usersArray)")
    }
    
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(addNewUser(_ :)),
                                           name: Notification.Name("addNewUserButton"),
                                           object: nil)
    FriendsData.shared.fillFriendsData()
    friendsArray = FriendsData.shared.sourceFriendsArray
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


