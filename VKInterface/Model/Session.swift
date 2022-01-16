//
//  Session.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.12.2021.
//

import Foundation
import RealmSwift

class Session: RealmSwift.Object {
  @Persisted var token: String = ""
  @Persisted var userId: String = ""
  var friendId: Any = ""
  
  convenience init(token: String, userId: String, friendId: Any) {
    self.init()
    self.token = token
    self.userId = userId
    self.friendId = friendId
  }
  public static let shared = Session()
  
}
