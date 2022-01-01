//
//  Users.swift
//  VKInterface
//
//  Created by Ivan Okhota on 01.01.2022.
//

import Foundation

// MARK: - Online Users

//struct Users {
//  let id: Int
//  let name: String
//  let surname: String
//  let avatar: URL
//  let track_code: String
//
//  enum CodingKeys: String, CodingKey {
//    case id = "id"
//    case name = "first_name"
//    case surname = "last_name"
//    case avatar = "photo_200_orig"
//    case track_code = "track_code"
//  }
//}
//
//extension Users: Codable {
//
//  init(from decoder: Decoder) throws {
//
//    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
//          let id = try? container.decode(Int.self, forKey: .id),
//          let name = try? container.decode(String.self, forKey: .name),
//          let surname = try? container.decode(String.self, forKey: .surname),
//          let avatar = try? container.decode(URL.self, forKey: .avatar),
//          let track_code = try? container.decode(String.self, forKey: .track_code)
//    else { throw NSError() }
//    self.id = id
//    self.name = name
//    self.surname = surname
//    self.avatar = avatar
//    self.track_code = track_code
//  }
//}

struct Users {
  let id: Int
  let first_name: String
  let last_name: String
  let photo_200_orig: URL
  let track_code: String
}

extension Users: Codable {
  
  init(from decoder: Decoder) throws {
    
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
          let id = try? container.decode(Int.self, forKey: .id),
          let first_name = try? container.decode(String.self, forKey: .first_name),
          let last_name = try? container.decode(String.self, forKey: .last_name),
          let photo_200_orig = try? container.decode(URL.self, forKey: .photo_200_orig),
          let track_code = try? container.decode(String.self, forKey: .track_code)
    else { throw NSError() }
    self.id = id
    self.first_name = first_name
    self.last_name = last_name
    self.photo_200_orig = photo_200_orig
    self.track_code = track_code
  }
}
