//
//  UserGroupVC+DataSource.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

extension UserGroupViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView,
                 numberOfRowsInSection section: Int) -> Int {
    userGroupsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentificator,
                                                   for: indexPath) as? CustomTableViewCell else {return UITableViewCell() }
  
    cell.configure(groups: userGroupsArray[indexPath.row])
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
}
