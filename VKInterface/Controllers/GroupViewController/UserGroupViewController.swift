//
//  UserGroupViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

class UserGroupViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let cellHeightGroupsViewController: CGFloat = 200
  
  var userGroupsArray = [Groups]()
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    fillUserGroupData()
    NotificationCenter.default.addObserver(self,
                                           selector:
                                            #selector(addUserNewGroup(_:)),
                                           name:
                                            Notification.Name("addNewGroupSelectNotification"),
                                           object: nil)
    self.navigationController?.delegate = self
  }
  
  func fillUserGroupData() {
    let group1 = Groups(name: "Simpsons", avatar: "bartAvatar")
    userGroupsArray.append(group1)
    
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
  
}
