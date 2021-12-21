//
//  CustomTableViewCell.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit

protocol CustomTableViewCellDelegate: AnyObject {
  func pressedPicture(friend: Friends)
}

class CustomTableViewCell: UITableViewCell {
  
  let blankAvatar = UIImage(named: "blankAvatar")
  
  @IBOutlet weak var customNameField: UILabel!
  @IBOutlet weak var customAvatar: UIImageView!
  @IBOutlet weak var customTableLayout: UIView!
  @IBOutlet weak var customAvatarButton: UIButton!
  @IBOutlet weak var ContentView: UIView!
  @IBOutlet weak var customCellButton: UIButton!
  
  weak var  delegate: CustomTableViewCellDelegate?
  
  var choosedFriend: Friends?
  
  override func prepareForReuse() {
    super.prepareForReuse()
    customAvatar.image = nil
    customNameField.text = nil
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(friends: Friends){
    
    customAvatar.image = blankAvatar
    self.choosedFriend = friends
    guard let customAvatarHeight = customAvatar.image?.cgImage?.height else { return }
    customAvatar.layer.cornerRadius = CGFloat (customAvatarHeight / 4)
    customTableLayout.layer.cornerRadius = CGFloat (customAvatarHeight / 4)
    customTableLayout.layer.shadowColor = UIColor.black.cgColor
    customTableLayout.layer.shadowRadius = 10
    customTableLayout.layer.shadowOffset = CGSize (width: 10, height: 10)
    customTableLayout.layer.shadowOpacity = 0.25
    print (customAvatarHeight)
    
    if let avatar = friends.avatar {
      customAvatar.image = UIImage(named: avatar)
    }
    
    if let surname = friends.surname {
      customNameField.text = "\(friends.name) \(surname)"
    } else {
      customNameField.text = friends.name
    }
  }
  
  func configure(groups: Groups){
    customAvatar.image = blankAvatar
    guard let avatar = groups.avatar else {return customAvatar.image = blankAvatar}
    customAvatar.image = UIImage(named: avatar)
    customNameField.text = groups.name
    customAvatarButton.alpha = 0
  }
  
  @IBAction func customAvatarButtonToFriendGallery(_ sender: Any) {
    let startFrame = customAvatar.frame
    UIView.animate(withDuration: 2,
                   animations: {[weak self] in
      guard let middleXVAlue = self?.customAvatar.frame.midX,
              let middleYValue =  self?.customAvatar.frame.midY else {return}
      self?.customAvatar.frame = CGRect(x: middleXVAlue,
                                        y: middleYValue,
                                        width: 0,
                                        height: 0)
    }, completion: { isSuccess in
      if isSuccess {
        UIView.animate(withDuration: 3,
                       animations: {[weak self] in
          guard let self = self else {return}
          self.customAvatar.frame = startFrame
        }, completion: { [weak self] isSuccess in
          if isSuccess, let self = self,
             let friend = self.choosedFriend {
            self.delegate?.pressedPicture(friend: friend)
          }
        })
      }
    })
  }
  @IBAction func customCellButton(_ sender: Any) {
    guard let choosedFriend = self.choosedFriend else {return}
    self.delegate?.pressedPicture(friend: choosedFriend)
  }
}
