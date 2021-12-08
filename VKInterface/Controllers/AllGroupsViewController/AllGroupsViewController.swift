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
  
  func fillAllGroupsData() {
    let group1 = Groups(name: "Swift", avatar: "swift")
    let group2 = Groups(name: "MetallMusic", avatar: "music")
    let group3 = Groups(name: "PunkMusic", avatar: "punk")
    let group4 = Groups(name: "Cars", avatar: "cars")
    let group5 = Groups(name: "Girls", avatar: "grils")
    let group6 = Groups(name: "Simpsons", avatar: "bartAvatar")
    allGroupsArray.append(group1)
    allGroupsArray.append(group2)
    allGroupsArray.append(group3)
    allGroupsArray.append(group4)
    allGroupsArray.append(group5)
    allGroupsArray.append(group6)
  }
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let cellHeightGroupsViewController: CGFloat = 150
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "CustomTableViewCell",
                             bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    fillAllGroupsData()
  }
}
