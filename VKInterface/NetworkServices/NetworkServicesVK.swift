//
//  VKFriendsList.swift
//  VKInterface
//
//  Created by Ivan Okhota on 04.01.2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class NetworkServices {
  
  private let userId = Session.shared.userId
  private let token = Session.shared.token
  private let host = "https://api.vk.com"
  private let version = "5.131"
  
  func vkFriendsList(_ completion: @escaping (Result<[Friends], Error>) -> Void ) {
    
    let path = "/method/friends.get"
    
    let parameters = [
      "access_token" : token,
      "owner_id" : userId,
      "order" : "hints",
      "fields" : "photo_200_orig",
      "name_case" : "nom",
      "v" : version
    ]
    AF.request(host + path, parameters: parameters)
      .validate()
      .response { response in
        switch response.result {
          case .failure(let error):
            completion(.failure(error))
          case .success(let data):
            guard let data = data,
                  let json = try? JSON(data: data) else { return }
            let friendsJson = json["response"]["items"].arrayValue
            let friends = friendsJson.map { Friends(json: $0) }
            completion(.success(friends))
        }
      }
  }
  
  func vkLogin() -> URLRequest {
    
    // MARK: - Standart SWIFT URLComponents
    //
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "oauth.vk.com"
    urlComponents.path = "/authorize"
    urlComponents.queryItems = [
      URLQueryItem(name: "client_id", value: "8034847"),
      URLQueryItem(name: "scope", value: "262148"),
      URLQueryItem(name: "display", value: "mobile"),
      URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
      URLQueryItem(name: "response_type", value: "token"),
      URLQueryItem(name: "user_id", value: "userId"),
      URLQueryItem(name: "v", value: "5.92")
      
    ]
    let errorURL = URL(string: "https://oauth.vk.com/blank.html")!
    guard let url = urlComponents.url else { return URLRequest(url: errorURL)}
    let request = URLRequest(url: url)
    return request
  }
  
  func vkFriendsOnline() {
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/friends.getOnline"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "v", value: version)
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
  func vkPhotosLoad() {
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/photos.get"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "owner_id", value: userId),
      URLQueryItem(name: "album_id", value: "wall"),
      URLQueryItem(name: "count", value: "50"),
      URLQueryItem(name: "v", value: version)
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
  func vkGroupList(completion: @escaping (Result<[Groups], Error>) -> Void) {
    let path = "/method/groups.get"
    let parameters: Parameters = [
      "access_token": token,
      "extended": 1,
      "v": version
    ]
    
    AF.request(host + path, parameters: parameters).response {
      response in
      switch response.result {
        case .failure(let error):
          completion(.failure(error))
        case .success(let data):
          guard let data = data,
                let json = try? JSON(data: data) else { return }
          
          let groupsJson = json["response"]["items"].arrayValue
          let groups = groupsJson.map { Groups(json: $0) }
          
          completion(.success(groups))
      }
    }
  }
  
  func vkFriendsSearch(search: String = "", completion: @escaping (Result<[Friends], Error>) -> Void ) {
    
    let path = "/method/friends.search"
    
    let parameters: Parameters = [
      "access_token" : token,
      "owner_id" : userId,
      "q": search,
      "fields" : "photo_200_orig",
      "name_case" : "nom",
      "offset" : 0,
      "count" : 50,
      "v" : version
    ]
    AF.request(host + path, parameters: parameters)
      .validate()
      .response { response in
        switch response.result {
          case .failure(let error):
            completion(.failure(error))
          case .success(let data):
            guard let data = data,
                  let json = try? JSON(data: data) else { return }
            let searchFriendsJson = json["response"]["items"].arrayValue
            let searchFriends = searchFriendsJson.map { Friends(json: $0) }
            completion(.success(searchFriends))
        }
      }
  }
  
  func VKFriendloadPhoto(friendId: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
    let path = "/method/photos.get"
    let parameters: Parameters = [
      "access_token": token,
      "extended": 1,
      "v": version,
      "owner_id": friendId,
      "album_id": "profile",
      "photo_sizes": 1
    ]
    
    AF.request(host + path, parameters: parameters).response {
      response in
      switch response.result {
        case .failure(let error):
          completion(.failure(error))
        case .success(let data):
          guard let data = data,
                let json = try? JSON(data: data) else { return }
          
          
          let friendPhotoJson = json["response"]["items"].arrayValue
          let friendPhoto = friendPhotoJson.map { Photo(json: $0) }
          
          completion(.success(friendPhoto))
      }
    }
  }
  
  func vkGroupSearch(searchText: String) {
    
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/groups.search"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "q", value: searchText),
      URLQueryItem(name: "offset", value: "3"),
      URLQueryItem(name: "count", value: "3"),
      URLQueryItem(name: "v", value: version)
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
}
