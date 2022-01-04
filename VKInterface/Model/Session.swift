//
//  Session.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.12.2021.
//

import Foundation
import RealmSwift

//
//class Session {
//  static let shared = Session()
//  private init() {}
//  var token = ""
//  var userId = ""
//}

class Session: RealmSwift.Object {
  @objc dynamic var token: String = ""
  @objc dynamic var userId: String = ""
  @objc dynamic var friendId: String = ""
  
  convenience init(token: String, userId: String, friendId: String) {
    self.init()
    
    self.token = token
    self.userId = userId
    self.friendId = friendId
  }
  public static let shared = Session()
  
}
