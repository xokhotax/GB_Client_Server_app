//
//  AllGroupsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var allGroupsArray = [Groups]()
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let cellHeightGroupsViewController = cellHeightFriendsViewController
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
  }
}
