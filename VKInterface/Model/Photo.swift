//
//  Photo.swift
//  VKInterface
//
//  Created by Ivan Okhota on 06.01.2022.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Photo: Object {

  @objc dynamic var url: String = ""
  @objc dynamic var iconUrl: URL? { URL(string: "\(url)") }
    
  convenience init(json: SwiftyJSON.JSON) {
        self.init()
        let firstJson = json["sizes"].arrayValue.first
        self.url = firstJson?["url"].stringValue ?? ""
    }
}
