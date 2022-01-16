//
//  FriendsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import Alamofire
import RealmSwift

class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarFriend: UISearchBar!
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let toGallerySeague = "toGallerySeague"
  var friendsArray = [Friends]()
  var sourceArray = [Friends]()
  
  let networkServices = NetworkServices()
  
  var friend: Results<Friends>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(Friends.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkServices.vkFriendsList { result in
      switch result {
        case let .failure(error):
          print(error)
        case let .success(friend):
          try? RealmService.save(items: friend, update: .modified)
          
          self.tableView.reloadData()
      }
    }
    
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(addNewUser(_ :)),
                                           name: Notification.Name("addNewUserButton"),
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


