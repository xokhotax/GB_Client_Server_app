//
//  VKFriendsList.swift
//  VKInterface
//
//  Created by Ivan Okhota on 04.01.2022.
//

import Foundation
import Alamofire

class NetworkServices {
  
  func vkFriendsList(_ completion: @escaping (UsersListResponse) -> Void ) {
    
    let userId = Session.shared.userId
    let token = Session.shared.token
    let host = "https://api.vk.com"
    let path = "/method/friends.get"
    
    let url = URL(string: host + path)!
    let parameters = [
      "access_token" : token,
      "owner_id" : userId,
      "order" : "hints",
      "fields" : "photo_200_orig",
      "name_case" : "nom",
      "v" : "5.131"
    ]
    AF.request(url, parameters: parameters)
      .validate()
      .responseDecodable { (response: AFDataResponse<UsersListResponse>)  in
        guard let response = response.value else { return }
        completion(response)
      } .resume()
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
      URLQueryItem(name: "v", value: "5.92")
      
    ]
    let errorURL = URL(string: "https://oauth.vk.com/blank.html")!
    guard let url = urlComponents.url else { return URLRequest(url: errorURL)}
    let request = URLRequest(url: url)
    return request
  }
  
  func vkFriendsOnline() {
    
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/friends.getOnline"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "v", value: "5.89")
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
  func vkPhotosLoad() {
    
    let userId = Session.shared.userId
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/photos.get"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "owner_id", value: userId),
      URLQueryItem(name: "album_id", value: "wall"),
      URLQueryItem(name: "count", value: "50"),
      URLQueryItem(name: "v", value: "5.89")
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
  func vkGroupList() {
    
    let userId = Session.shared.userId
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/groups.get"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "owner_id", value: userId),
      URLQueryItem(name: "count", value: "5"),
      URLQueryItem(name: "v", value: "5.89")
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: nil)
  }
  
}
