//
//  FriendsVC+Delegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

extension FriendsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellHeightFriendsViewController
  }
  
  // MARK: - Delete of users
  func tableView(_ tableView: UITableView,
                 commit editingStyle: UITableViewCell.EditingStyle,
                 forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let alertController = UIAlertController(title: "Удаление пользователя",
                                              message: "Подтвердите удаление пользователя",
                                              preferredStyle: .actionSheet)
      
      let actionYes = UIAlertAction(title: "Да", style: .default) {[ weak self ] _ in
        guard let self = self else { return }
        let friend = self.friend?[indexPath.row]
        do {
          let realm = try? Realm()
          guard let friend = friend else {return}
          try realm?.write({
            realm?.delete(friend)
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
  
  // MARK: - Jump by Seague
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == toGallerySeague,
       let pickedCell = sender as? CustomTableViewCell,
       let cellIndexPath = tableView.indexPath(for: pickedCell),
    let galleryViewController = segue.destination as? GalleryViewController {
      let choosedFriend = friend?[cellIndexPath.item]
      guard let choosedFriend = choosedFriend else { return }
      
      galleryViewController.choosedFriend = choosedFriend
      Session.shared.friendId = choosedFriend 
    }
  }
}
