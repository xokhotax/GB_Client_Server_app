//
//  AllGroupsVC+Deligate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

extension AllGroupsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellHeightGroupsViewController
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NotificationCenter.default.post(name: Notification.Name("addNewGroupSelectNotification"),
                                    object: groups?[indexPath.row])
  }
  
}
