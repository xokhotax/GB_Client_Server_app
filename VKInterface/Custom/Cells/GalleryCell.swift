//
//  GalleryCell.swift
//  VKInterface
//
//  Created by Ivan Okhota on 30.11.2021.
//

import UIKit
import Kingfisher

@IBDesignable class GalleryCell: UICollectionViewCell {
  
  @IBOutlet weak var likeController: LikeController!
  @IBOutlet weak var backgroundCellView: UIView!
  @IBOutlet weak var photoImageView: UIImageView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.image = nil
  }
  
  func configure(friendImage: Photo){
    photoImageView.kf.setImage(with: friendImage.iconUrl)
    likeController.isHidden = true
  }
  
  func configureBigImage(image: UIImage?){
    let pictureWidth = Int (UIScreen.main.bounds.width * 0.95)
    guard let bigPictureHeight = image?.cgImage?.height else { return }
    let targetSize = CGSize(width: pictureWidth, height: bigPictureHeight)
    photoImageView.image = image?.scalePreservingAspectRatio(targetSize: targetSize)
  }
}
