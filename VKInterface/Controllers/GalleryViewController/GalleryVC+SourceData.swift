 //
//  GalleryVC+SourceData.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit

extension GalleryViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return sourceArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reUseIdentificator",
                                                  for: indexPath) as! GalleryCell
    cell.configure(image: UIImage(named: sourceArray[indexPath.item]))
    return cell
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int{
    return 1
  }

}
