//
//  AllGroupsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

class AllGroupsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var groups = UserGroupViewController().userGroup
  
  
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let cellHeightGroupsViewController: CGFloat = 150
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
  }
}
