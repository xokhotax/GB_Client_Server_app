//
//  Groups.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

//struct Groups {
//  var name: String
//  var avatar: String?
//}
//

import UIKit
import SwiftyJSON
import RealmSwift

class Groups: Object {
  @Persisted var name: String = ""
  @Persisted  var photoUrl: String = ""
  @objc dynamic var avatar: URL? { URL(string: "\(photoUrl)") }
  @Persisted var id = ""
  
  override static func primaryKey() -> String? {
    return "id"
  }
  
  
  convenience init(json: SwiftyJSON.JSON) {
    self.init()
    
    self.name = json["name"].stringValue
    self.photoUrl = json["photo_100"].stringValue
    self.id = json["id"].stringValue
  }
}
