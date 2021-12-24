//
//  VKLoginScreenVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import UIKit
import WebKit

class VKLoginScreenVC: UIViewController {
  @IBOutlet weak var webView: WKWebView!
  @IBOutlet weak var scrollView: UIScrollView!
  
  private func vkLogin() {
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
    guard let url = urlComponents.url else {return}
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
    vkFriendsOnline()
    vkPhotosLoad()
    vkFriendsList()
    vkGroupList()
  }
  
}
