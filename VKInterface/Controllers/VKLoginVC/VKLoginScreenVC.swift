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
  
  private let networkServices = NetworkServices()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    webView.navigationDelegate = self
    webView.load(networkServices.vkLogin())
    
  }
  
    //    print ("Друзья онлайн \(vkFriendsOnline())")
    //    print ("Загрузка фото \(vkPhotosLoad())")
    //    vkGroupList()
  
  
}
