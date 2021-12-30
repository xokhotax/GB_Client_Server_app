//
//  Friends.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

struct Friends {
  var name: String
  var surname: String?
  var avatar: String?
  var photoGallery: [String]?
}

protocol FriendsDataLoad: AnyObject {
  func dataLoad (friends: Friends)
}

class FriendsData {
  
  static let shared = FriendsData()
  private init() {}
  
  var sourceFriendsArray = [Friends]()
  
  weak var delegate: FriendsDataLoad?
  
  func fillFriendsData() {
    let friendOne = Friends(name: "Вася",
                            surname: "Попов",
                            avatar: "bartAvatar",
                            photoGallery: ["homer", "lisa", "bart", "all", "homer2"])
    let friendTwo = Friends(name: "Мария",
                            surname: "Петрова",
                            avatar: nil,
                            photoGallery: ["fg1", "fg2","fg3", "fg4", "fg5"])
    let friendThree = Friends(name: "Инокентий",
                              surname: nil,
                              avatar: "dipperAvatar",
                              photoGallery: ["gf1", "gf2", "gf3", "gf4", "gf5"])
    self.delegate?.dataLoad(friends: friendOne)
    self.delegate?.dataLoad(friends: friendTwo)
    self.delegate?.dataLoad(friends: friendThree)
    sourceFriendsArray.append(friendOne)
    sourceFriendsArray.append(friendTwo)
    sourceFriendsArray.append(friendThree)
  }
}
