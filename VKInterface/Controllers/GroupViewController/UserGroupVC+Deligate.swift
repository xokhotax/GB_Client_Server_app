//
//  UserGroupVC+Deligate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

extension UserGroupViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellHeightGroupsViewController
  }
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    let alertController = UIAlertController(title: "Удаление группы",
                                            message: "Подтвердите удаление группы",
                                            preferredStyle: .actionSheet)
      let actionYes = UIAlertAction(title: "Да", style: .default) {[weak self] _ in
        guard let self = self else { return }
        self.userGroupsArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
      alertController.addAction(actionYes)
      let actionNo = UIAlertAction (title: "Нет", style: .cancel, handler: nil)
      alertController.addAction(actionNo)
      
      self.present(alertController, animated: true, completion: nil)
    }
  }
}
