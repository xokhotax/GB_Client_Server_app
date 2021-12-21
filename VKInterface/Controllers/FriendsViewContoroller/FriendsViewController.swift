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
  
  weak var delegate: FriendsDelegate? 
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let toGallerySeague = "toGallerySeague"
  var friendsArray = [Friends]()

  private let friendsData = FriendsData()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    friendsData.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(addNewUser(_ :)),
                                           name: Notification.Name("addNewUserButton"),
                                           object: nil)
    friendsData.fillFriendsData()
    friendsArray = friendsData.sourceFriendsArray
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


