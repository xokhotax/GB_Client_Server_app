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
    @objc dynamic var name: String = ""
    @objc dynamic var photoUrl: String = ""
    @objc dynamic var avatar: URL? { URL(string: "\(photoUrl)") }
        
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        
        self.name = json["name"].stringValue
        self.photoUrl = json["photo_100"].stringValue
    }
}
