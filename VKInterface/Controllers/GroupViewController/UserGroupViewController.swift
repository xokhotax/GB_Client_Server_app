//
//  UserGroupViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

class UserGroupViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  let cellHeightGroupsViewController: CGFloat = 200
  private var token: NotificationToken?
  var userGroupsArray = [Groups]()
  var userGroup: Results<Groups>? = try? Realm(configuration: RealmService.deleteIfMigration).objects(Groups.self)
  private let networkServices = NetworkServices()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    networkServices.vkGroupList { [weak self] result in
      switch result {
        case let .failure(error):
          print(error)
        case let .success(group):
          guard let self = self else { return }
          try? RealmService.save(items: group, update: .modified)
          self.tableView.reloadData()
      }
    }
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(addUserNewGroup(_:)),
                                           name:
                                            Notification.Name("addNewGroupSelectNotification"),
                                           object: nil)
    changeRealmCollection() 
    self.navigationController?.delegate = self
  }

  @objc func addUserNewGroup (_ notification: Notification) {
    guard let groupObject = notification.object as? Groups else { return }
    
    if userGroupsArray.contains(where: { allGroupsArray in
      allGroupsArray.name == groupObject.name
    }) {
      print ("Группа уже добавлена")
    }
    else {
      userGroupsArray.append(groupObject)
      tableView.reloadData()
    }
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func changeRealmCollection() {
    guard let userGroup = userGroup else { return }
    self.token = userGroup.observe { (change: RealmCollectionChange) in
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
  
  
}
