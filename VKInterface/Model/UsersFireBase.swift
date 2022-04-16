//
//  UsersFireBase.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.01.2022.
//

import Foundation
import FirebaseDatabase
import FirebaseFirestore

struct UserFireBase {
  let email: String?
  let iD: String?
  let groupName: [String]?
}

extension UserFireBase: Codable {}
