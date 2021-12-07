////
////  FriendsVC+Delegate+Search.swift
////  VKInterface
////
////  Created by Ivan Okhota on 05.12.2021.
////
//
//import UIKit
//
//extension FriendsViewController: UISearchBarDelegate {
//  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//    friendsArray = searchText.isEmpty ? friendsArray : friendsArray.filter {
//      (item: String) -> Bool in
//              return item.range(of: searchText, options: .caseInsensitive,
//                                range: nil,
//                                locale: nil) != nil
//          }
//          tableView.reloadData()
//      }
//}
