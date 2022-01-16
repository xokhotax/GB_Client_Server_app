//
//  FriendsVC+UITableViewDataSource.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import RealmSwift

extension FriendsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let quantity = friend?.count else { return 0 }
    return quantity
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentificator,
                                                   for: indexPath) as? CustomTableViewCell,
          let friends = friend?[indexPath.item] else { return UITableViewCell() }
    cell.configure(friend: friends)
        cell.delegate = self
    
    return cell
  }
}

extension FriendsViewController: CustomTableViewCellDelegate {
  func pressedPicture(choosedFriend: Friends) {
    performSegue(withIdentifier: toGallerySeague, sender: choosedFriend)
    
  }
}
