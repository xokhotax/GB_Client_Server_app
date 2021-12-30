//
//  FriendsVC+UITableViewDataSource.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

extension FriendsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friendsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentificator,
                                                   for: indexPath) as? CustomTableViewCell else {return UITableViewCell() }
    cell.configure(friends: friendsArray[indexPath.row])
    cell.delegate = self
    
    return cell
  } 
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

extension FriendsViewController: CustomTableViewCellDelegate {
  func pressedPicture(friend: Friends) {
    if let friendsFotoArray = friend.photoGallery  {
         performSegue(withIdentifier: toGallerySeague, sender: friendsFotoArray)
       }
  }
  
  
}
