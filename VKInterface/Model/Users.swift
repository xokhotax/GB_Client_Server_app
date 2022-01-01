//
//  Users.swift
//  VKInterface
//
//  Created by Ivan Okhota on 01.01.2022.
//

import Foundation

// MARK: - Online Users

struct UsersListResponse {
  enum CodingKeys: String, CodingKey {
    case response
  }
  let response: ResponseStruct
}

extension UsersListResponse: Decodable {
  init(from decoder: Decoder) throws {
   guard let container = try? decoder.container(keyedBy: CodingKeys.self),
    let response = try? container.decode(ResponseStruct.self, forKey: .response)
    else { throw NSError() }
    self.response = response
  }
}

struct ResponseStruct {
  enum CodingKeys: String, CodingKey {
    case count
    case items
  }
  
  let count: Int
  let items: [Users]
}

extension ResponseStruct: Decodable {
  init(from decoder: Decoder) throws {
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
          let count = try? container.decode(Int.self, forKey: .count),
          let items = try? container.decode([Users].self, forKey: .items)
    else { throw NSError() }
    self.count = count
    self.items = items
  }
}

struct Users {
  let id: Int
  let name: String
  let surname: String
  let canAccessClosed: Bool
  let isClosed: Bool
  let avatar: URL
  let track_code: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "first_name"
    case surname = "last_name"
    case canAccessClosed = "can_access_closed"
    case isClosed = "is_closed"
    case avatar = "photo_200_orig"
    case track_code = "track_code"
  }
}

extension Users: Codable {
  
  init(from decoder: Decoder) throws {
    
    guard let container = try? decoder.container(keyedBy: CodingKeys.self),
          let id = try? container.decode(Int.self, forKey: .id),
          let name = try? container.decode(String.self, forKey: .name),
          let surname = try? container.decode(String.self, forKey: .surname),
          let canAccessClosed = try? container.decode(Bool.self, forKey: .canAccessClosed),
          let isClosed = try? container.decode(Bool.self, forKey: .isClosed),
          let avatar = try? container.decode(URL.self, forKey: .avatar),
          let track_code = try? container.decode(String.self, forKey: .track_code)
    else { throw NSError() }
    self.id = id
    self.name = name
    self.surname = surname
    self.canAccessClosed = canAccessClosed
    self.isClosed = isClosed
    self.avatar = avatar
    self.track_code = track_code
  }
}
