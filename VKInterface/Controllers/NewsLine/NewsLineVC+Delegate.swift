//
//  NewsLineVC+Delegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.02.2022.
//

import UIKit

extension NewsLineVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat{
    return cellHeightNewsLineViewController
  }
}
