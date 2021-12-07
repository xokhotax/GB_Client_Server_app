//
//  GalleryViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit

class GalleryViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  var sourceArray = ["blankAvatar"]
  let toBigUsersGalleryVC = "toBigUsersGalleryVC"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                            forCellWithReuseIdentifier: "reUseIdentificator")
    collectionView.reloadData()
  }
}

