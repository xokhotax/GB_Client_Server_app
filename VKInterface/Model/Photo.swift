//
//  Photo.swift
//  VKInterface
//
//  Created by Ivan Okhota on 06.01.2022.
//

import UIKit
import SwiftyJSON
import RealmSwift

class Photo {

    private let url: String
    var iconUrl: URL? { URL(string: "\(url)")}
    
    init(json: JSON) {

        let firstJson = json["sizes"].arrayValue.first
        self.url = firstJson?["url"].stringValue ?? ""
    }
}
