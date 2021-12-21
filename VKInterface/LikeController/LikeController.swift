//
//  LikeController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 05.12.2021.
//

import UIKit

class LikeController: UIView {
  
  @IBOutlet weak var dislikeButton: UIButton!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var counterLabel: UILabel!
  
  weak var delegate: LikeController?
  
  private var view: UIView?
  
  var activeLikeButtonStatus = false
  var activeDislikeButtonStatus = false
  var countLikes = 0
  
  required init?(coder: NSCoder) {
    super .init(coder: coder)
    setup()
  }
  
  private func loadFromNimb() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: "LikeController", bundle: bundle)
    guard let view = nib.instantiate(withOwner: self,
                                     options: nil).first as? UIView else {return UIView()}
    return view
  }
  
  private func setup() {
    view = loadFromNimb()
    guard let view = view else {return}
    view.frame = bounds
    view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    addSubview(view)
  }
  
  @IBAction func pressLikeButton(_ sender: Any) {
    switch activeLikeButtonStatus {
      case true:
        UIView.transition(with: likeButton,
                          duration: 1,
                          options: .transitionFlipFromTop,
                          animations: { [weak self] in
          guard let self = self else {return}
          self.likeButton.setImage(UIImage(systemName: "hand.thumbsup"),
                                   for: .normal)
        },completion: { [weak self] _ in
          guard let self = self else {return}
          self.countLikes -= 1
          self.counterLabel.text = String(self.countLikes)})
      default:
        UIView.transition(with: likeButton,
                          duration: 1,
                          options: .transitionFlipFromTop,
                          animations: { [weak self] in
          guard let self = self else {return}
          self.likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"),
                                   for: .normal)
        },completion: { [weak self] _ in
          guard let self = self else {return}
          self.countLikes += 1
          self.counterLabel.text = String(self.countLikes)})
    }
    activeLikeButtonStatus = !activeLikeButtonStatus
  }
  
  @IBAction func pressDislikeButton(_ sender: Any) {
    switch activeDislikeButtonStatus {
      case true:
        UIView.transition(with: dislikeButton,
                          duration: 1,
                          options: .transitionFlipFromTop,
                          animations: { [weak self] in
          guard let self = self else {return}
          self.dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown"),
                                      for: .normal)
        },completion: { [weak self] _ in
          guard let self = self else {return}
          self.countLikes += 1
          self.counterLabel.text = String(self.countLikes)})
      default:
        UIView.transition(with: dislikeButton,
                          duration: 1,
                          options: .transitionFlipFromTop,
                          animations: { [weak self] in
          guard let self = self else {return}
          self.dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown.fill"),
                                      for: .normal)
        },completion: { [weak self] _ in
          guard let self = self else {return}
          self.countLikes -= 1
          self.counterLabel.text = String(self.countLikes)})
    }
    activeDislikeButtonStatus = !activeDislikeButtonStatus
  }
}
