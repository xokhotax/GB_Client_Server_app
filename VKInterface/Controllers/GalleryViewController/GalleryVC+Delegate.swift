//
//  GalleryVC+Delegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDelegate {
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == toBigUsersGalleryVC,
       let selectedFriendsFoto = sender as? String,
       let destination = segue.destination as? BigUsersGalleryVC {
      destination.sourceArray.append(selectedFriendsFoto)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedFriendsFoto = sourceArray[indexPath.item]
    performSegue(withIdentifier: toBigUsersGalleryVC, sender: selectedFriendsFoto)
  }
  
  
}

