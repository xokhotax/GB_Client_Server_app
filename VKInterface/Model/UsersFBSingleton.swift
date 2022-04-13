//
//  UsersFBSingleton.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.01.2022.
//

import Foundation

class UsersFBSingleton {
  
  static let shared = UsersFBSingleton()
  
  var uid: String = ""
  var email: String = ""
  
  private init() {}
  
}
