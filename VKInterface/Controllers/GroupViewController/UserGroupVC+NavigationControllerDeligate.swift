//
//  UserGroupVC+NavigationControllerDeligate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 13.12.2021.
//

import UIKit

extension UserGroupViewController: UINavigationControllerDelegate {
  func navigationController(_ navigationController: UINavigationController,
                            animationControllerFor operation: UINavigationController.Operation,
                            from fromVC: UIViewController,
                            to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if operation == .push {
      return CustomAnimationOpener()
    }
    return CustomAnimationOpener()
  }
}
