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

  @IBAction func unwindAndClearCookies(segue: UIStoryboardSegue) {
      let cookieStore = webView.configuration.websiteDataStore.httpCookieStore
    
      cookieStore.getAllCookies {
          cookies in
          
          for cookie in cookies {
              cookieStore.delete(cookie)
          }
      }
      webView.load(networkServices.vkLogin())
  }
}
