//
//  GalleryViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit

class GalleryViewController: UIViewController {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var swipeGalleryImage: UIImageView!
  @IBOutlet weak var swipeGalleryLayout: UIView!
  @IBOutlet weak var swipeGallerySecondView: UIView!
  @IBOutlet weak var swipeGallerySecondImage: UIImageView!
  
  var sourceArray: [String] = []
  private var interactiveAnimation: UIViewPropertyAnimator!
  let toBigUsersGalleryVC = "toBigUsersGalleryVC"
  private var i = 0
  
  private func inputDataToswipeGalleryImage() {
    guard let transferedGallery = UIImage(named: sourceArray[i]) else {return}
    swipeGalleryImage.image = transferedGallery
    swipeGallerySecondImage.image = transferedGallery
  }
  
  private func nextPictureToswipeGalleryImage() {
    if i < sourceArray.count {
      guard let transferedGallery = UIImage(named: sourceArray[i]) else {return}
      swipeGalleryImage.image = transferedGallery
      swipeGallerySecondImage.image = transferedGallery
      i += 1
    } else if i >= sourceArray.count {
      i = 0
    }
  }
  
  @objc func onPan (_ gestureRognizer: UIPanGestureRecognizer) {
    
    switch gestureRognizer.state {
      case .began:

        interactiveAnimation?.startAnimation()
        interactiveAnimation = UIViewPropertyAnimator(duration: 1,
                                                      curve: .linear,
                                                      animations: {})
        interactiveAnimation.stopAnimation(true)
        
      case .changed:
        let translation = gestureRognizer.translation(in: self.view)
        if translation.x > 0 {
          interactiveAnimation.stopAnimation(true)
          interactiveAnimation.addAnimations { [weak self] in
            guard let self = self else {return}
            self.swipeGalleryLayout.transform = CGAffineTransform(scaleX: 0.1,
                                                                  y: 0.1)
            self.swipeGalleryImage.alpha = 0
            self.swipeGallerySecondView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width,
                                                                      y: 0)
          }
          interactiveAnimation.addCompletion { [weak self] _ in
            guard let self = self else {return}
            self.nextPictureToswipeGalleryImage()
            self.swipeGalleryImage.alpha = 1
            self.swipeGallerySecondView.alpha = 0
            self.swipeGalleryLayout.transform = CGAffineTransform(scaleX: 1,
                                                                  y: 1)
            self.swipeGallerySecondView.transform = .identity
          }
          interactiveAnimation.startAnimation()
          interactiveAnimation.pauseAnimation()
          interactiveAnimation.fractionComplete = translation.x / UIScreen.main.bounds.width
        }
        
      case .ended:
        interactiveAnimation.continueAnimation(withTimingParameters: nil,
                                               durationFactor: 0)
        
      @unknown default: return
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UINib(nibName: "GalleryCell", bundle: nil),
                            forCellWithReuseIdentifier: "reUseIdentificator")
    inputDataToswipeGalleryImage()
    let gestureRecognizer = UIPanGestureRecognizer(target: self,
                                                   action: #selector(onPan(_:)))
    self.view.addGestureRecognizer(gestureRecognizer)
    
    collectionView.reloadData()
    
  }
}

