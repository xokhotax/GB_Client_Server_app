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
    guard let quantity = userGroup?.count else { return 0 }
    return quantity
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentificator,
                                                   for: indexPath) as? CustomTableViewCell,
          let userGroup = userGroup?[indexPath.item] else { return UITableViewCell() }
    
    cell.configure(groups: userGroup)
    
    return cell
  }
}
