//
//  VKLoginScreenVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import UIKit
import WebKit
import Alamofire

class VKLoginScreenVC: UIViewController {
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  private func vkLogin() {
    
    
    // MARK: - Alamofire
    //
//    let url = URL(string: "https://oauth.vk.com/authorize")!
//    let parameters = [
//      "client_id": "8034847",
//      "display": "mobile",
//      "redirect_uri": "https://oauth.vk.com/blank.html",
//      "scope" : "262150",
//      "response_type" : "token",
//      "user_id" : "userId",
//      "v" : "5.89"
//    ]
//    AF.request(url, method: .post, parameters: parameters) { [ weak self ] response in
//
//      guard let self = self else { return }
//      let response = response
//      debugPrint (response)
//      DispatchQueue.main.async {
//        self.webView.load(response)
//      }
//    }
//  }
  
  
  // MARK: - Standart SWIFT URLComponents
  
      var urlComponents = URLComponents()
      urlComponents.scheme = "https"
      urlComponents.host = "oauth.vk.com"
      urlComponents.path = "/authorize"
      urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: "8034847"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "262150"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "user_id", value: "userId"),
        URLQueryItem(name: "v", value: "5.89")
      ]
      guard let url = urlComponents.url else { return }
      let request = URLRequest(url: url)
      webView.load(request)
    }
  
  private func vkFriendsOnline() {
    
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/friends.getOnline"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "v", value: "5.89")
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: webView)
  }
  
  private func vkPhotosLoad() {
    
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
    vkPrintDataToConsole(urlComponents: urlComponents, webView: webView)
  }
  
  private func vkFriendsList() {
    
    let userId = Session.shared.userId
    let token = Session.shared.token
    
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.vk.com"
    urlComponents.path = "/method/friends.getLists"
    urlComponents.queryItems = [
      URLQueryItem(name: "access_token", value: token),
      URLQueryItem(name: "owner_id", value: userId),
      URLQueryItem(name: "v", value: "5.89")
    ]
    vkPrintDataToConsole(urlComponents: urlComponents, webView: webView)
  }
  
  private func vkGroupList() {
    
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
    vkPrintDataToConsole(urlComponents: urlComponents, webView: webView)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    vkLogin()
  }
  
  @IBAction func LoginButton(_ sender: Any) {
    performSegue(withIdentifier: "fromLoginScreenToWelcomePage",
                 sender: nil)
    print ("Друзья онлайн \(vkFriendsOnline())")
    print ("Загрузка фото \(vkPhotosLoad())")
    print ("Список друзей \(vkFriendsList())")
    vkGroupList()
  }
  
}

