//
// FriendsViewController.swift
// VKInterface
//
// Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarFriend: UISearchBar!
  
  var friendsArray = [Friends]()
  var sourceArray = [Friends]()
  private var token: NotificationToken?
  private let networkServices = NetworkServices()
  var friend: Results<Friends>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(Friends.self)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadDataFromVKToRealm()
    changeRealmCollection()
    
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    tableView.reloadData()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func changeRealmCollection() {
    guard let friend = friend else { return }
    self.token = friend.observe { (change: RealmCollectionChange) in
      switch change {
        case .initial:
          self.tableView.reloadData()
        case let .update ( _, deletions, insertions, modifications):
          self.tableView.beginUpdates()
          self.tableView.insertRows(at:insertions.map({IndexPath(row:$0,
                                                                 section:0)}),
                                    with: .automatic)
          self.tableView.deleteRows(at:deletions.map({IndexPath(row:$0,
                                                                section:0)}),
                                    with:.automatic)
          self.tableView.reloadRows(at:modifications.map({IndexPath(row:$0,
                                                                    section:0)}),
                                    with:.automatic)
          self.tableView.endUpdates()
          
        case let .error (error):
          print("\(error)")
      }
    }
  }
  func loadDataFromVKToRealm(){
    networkServices.vkFriendsList { result in
      switch result {
        case let .failure(error):
          print(error)
        case let .success(friend):
          try? RealmService.save(items: friend, update: .modified)
          self.tableView.reloadData()
      }
    }
  }
}


