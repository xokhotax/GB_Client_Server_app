//
//  BigUsersGalleryVC+SourceData.swift
//  VKInterface
//
//  Created by Ivan Okhota on 01.12.2021.
//

import UIKit

extension BigUsersGalleryVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return sourceArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reUseIdentificator",
                                                  for: indexPath) as! GalleryCell
    cell.configureBigImage(image: UIImage(named: sourceArray[indexPath.item]))
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int{
    return 1
  }
}


