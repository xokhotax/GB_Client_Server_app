//
//  FriendsVC+SearchBar+Delegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 08.12.2021.
//

import UIKit


extension FriendsViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    
    if searchText .isEmpty{
     friendsArray = sourceArray
    } else {
      self.friendsArray = friendsArray.filter({ friendItem in
        friendItem.firstName.lowercased().contains(searchText.lowercased())
      })
    }
    self.tableView.reloadData()
  }
}
