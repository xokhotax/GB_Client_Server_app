//
//  vkprintDataToConsole.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import Foundation
import WebKit

func vkPrintDataToConsole(urlComponents : URLComponents, webView: WKWebView?) {
  guard let url = urlComponents.url else { return }
  let configuration = URLSessionConfiguration.default
  let session =  URLSession(configuration: configuration)
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  let task = session.dataTask(with: request) { (data, response, error) in
    guard let data = data,
          let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) else { return }
    print(json)
    
    session.dataTask(with: url) { data, response, error in
      guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
              return
            }
      let array = [json]
      for userJson in array {
        let userJson = userJson as! [String: Any]
        let id = userJson["id"] as! Int
        let name = userJson["frist_name"] as! String
        let surname = userJson["last_name"] as! String
        let avatar = userJson["photo_200_orig"] as! [String: Any]
        print(id, name, surname, avatar)
        
      }
    }.resume()
    
  }
  task.resume()
  webView?.load(request)
  return ()
}
