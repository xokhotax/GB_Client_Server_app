//
//  FriendsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarFriend: UISearchBar!
  
  weak var delegate: FriendsDataLoad? 
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let toGallerySeague = "toGallerySeague"
  var friendsArray = [Friends]()

  let friendsData = FriendsData.shared.sourceFriendsArray
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    FriendsData.shared.delegate = self
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


