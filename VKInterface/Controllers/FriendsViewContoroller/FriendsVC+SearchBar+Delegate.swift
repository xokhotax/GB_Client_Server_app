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
      friendsArray = FriendsData.shared.sourceFriendsArray
    } else {
      friendsArray = FriendsData.shared.sourceFriendsArray.filter({ friendItem in
        friendItem.name.lowercased().contains(searchText.lowercased())
      })
    }
    tableView.reloadData()
  }
}
