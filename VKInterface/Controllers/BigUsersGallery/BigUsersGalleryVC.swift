//
//  BigUsersGalleryVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 01.12.2021.
//

import UIKit

class BigUsersGalleryVC: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var likeController: UIView!
  
  var sourceArray: [String] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                            forCellWithReuseIdentifier: "reUseIdentificator")
    
    //    collectionView.delegate = self
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                      action: #selector(tapped(_:)))
    self.view.addGestureRecognizer(tapGestureRecognizer)
    
    let longPressRecognizer = UILongPressGestureRecognizer(target: self,
                                                           action: #selector(longPressed(_:)))
    self.view.addGestureRecognizer(longPressRecognizer)
    
  }
  
  @objc func tapped (_ recognizer: UITapGestureRecognizer) {
    print ("pressed")
  }
  
  @objc func longPressed(_ sender: UILongPressGestureRecognizer)
  {
    print ("longpressed")
  }
  
  
}
