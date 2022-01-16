//
//  UIImage+Resize.swift
//  VKInterface
//
//  Created by https://www.advancedswift.com/resize-uiimage-no-stretching-swift/
// on 04.12.2021.
//

import UIKit

extension UIImage {
  func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
    let widthRatio = targetSize.width / size.width
    let heightRatio = targetSize.height / size.height
    
    let scaleFactor = min(widthRatio, heightRatio)

    let scaledImageSize = CGSize(
      width: size.width * scaleFactor,
      height: size.height * scaleFactor
    )
    
    // Draw and return the resized UIImage
    let renderer = UIGraphicsImageRenderer(
      size: scaledImageSize
    )
    
    let scaledImage = renderer.image { _ in
      self.draw(in: CGRect(
        origin: .zero,
        size: scaledImageSize
      ))
    }
    
    return scaledImage
  }
}
