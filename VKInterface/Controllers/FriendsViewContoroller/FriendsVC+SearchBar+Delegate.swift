//
//  FriendsVC+SearchBar+Delegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 08.12.2021.
//

import UIKit

extension FriendsViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
    let friendsData = FriendsData()
    if searchText .isEmpty{
      friendsArray = friendsData.sourceFriendsArray
    } else {
      friendsArray = friendsData.sourceFriendsArray.filter({ friendItem in
        friendItem.name.lowercased().contains(searchText.lowercased())
      })
    }
    tableView.reloadData()
  }
}
