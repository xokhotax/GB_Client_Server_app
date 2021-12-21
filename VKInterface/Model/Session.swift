//
//  Session.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.12.2021.
//

class Session {
  static let shared = Session()
  private init() {}
  var token = ""
  var userId = 0
}
