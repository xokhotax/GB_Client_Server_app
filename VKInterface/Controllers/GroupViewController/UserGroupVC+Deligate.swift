//
//  UserGroupVC+Deligate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

extension UserGroupViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellHeightGroupsViewController
  }
  // MARK: - Delete of users
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let alertController = UIAlertController(title: "Удаление группы",
                                              message: "Подтвердите удаление группы",
                                              preferredStyle: .actionSheet)
      
      let actionYes = UIAlertAction(title: "Да", style: .default) {[ weak self ] _ in
        guard let self = self else { return }
        let userGroup = self.userGroup?[indexPath.row]
        do {
          let realm = try? Realm()
          guard let userGroup = userGroup else {return}
          try realm?.write({
            realm?.delete(userGroup)
          })
        } catch {
          print(error)
        }
      }
      alertController.addAction(actionYes)
      let actionNo = UIAlertAction (title: "Нет", style: .cancel, handler: nil)
      alertController.addAction(actionNo)
      
      self.present(alertController, animated: true, completion: nil)
    }
  }
}
