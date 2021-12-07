//
//  GalleryVC+UICollectionViewDelegateFlowLayout.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    let cellWindth = collectionView.frame.width/2 - 16
    
    return CGSize(width: cellWindth, height: cellWindth)
  }
}

