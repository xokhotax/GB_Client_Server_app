//
//  VKLoginVC+WebViewDelegate.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import WebKit

extension VKLoginScreenVC: WKNavigationDelegate {
  func webView(_ webView: WKWebView,
               decidePolicyFor navigationResponse: WKNavigationResponse,
               decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
    
    guard let url = navigationResponse.response.url,
          url.path == "/blank.html",
          let fragment = url.fragment else {
            decisionHandler(.allow)
            return
          }
    
    let parameters = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=") }
      .reduce([String: String]()) { result, param in
        var dict = result
        let key = param[0]
        let value = param[1]
        dict[key] = value
        return dict
      }
    
    guard let token = parameters["access_token"],
          let userId = parameters ["user_id"] else { return }
    
    let session = Session.shared
    session.token = token
    session.userId = userId
    
    decisionHandler(.cancel)
    
  }
}
