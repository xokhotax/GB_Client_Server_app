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
    
    
    // MARK: - Alamofire
    //
    //    let url = URL(string: "https://oauth.vk.com/authorize")!
    //    let parameters = [
    //      "client_id" : "8034847",
    //      "display" : "mobile",
    //      "redirect_uri": "https://oauth.vk.com/blank.html",
    //      "scope" : "262150",
    //      "response_type" : "token",
    //      "user_id" : "userId",
    //      "v" : "5.89"
    //    ]
    //    AF.request(url, parameters: parameters).responseJSON { [ weak self ] response in
    //
    //      guard let response = response.value,
    //            let url = URL(string: response as! String) else { return }
    //      print (response)
    //      let responseURLRequest = URLRequest(url: url)
    //      DispatchQueue.main.async {
    //        guard let self = self else { return }
    //        self.webView.load(responseURLRequest)
    //      }
    //    }
    //  }
    
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
      URLQueryItem(name: "v", value: version)
      
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
  
  func VKFriendloadPhoto(owner: String, completion: @escaping (Result<[Photo], Error>) -> Void) {
  let path = "/method/photos.get"
  let parameters: Parameters = [
      "access_token": token,
      "extended": 1,
      "v": "5.131",
      "owner_id": owner,
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
  
}
