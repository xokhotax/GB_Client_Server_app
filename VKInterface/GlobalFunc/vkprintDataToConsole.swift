//
//  vkprintDataToConsole.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import Foundation
import WebKit

func vkPrintDataToConsole(urlComponents : URLComponents, webView: WKWebView) {
  guard let url = urlComponents.url else {return}
  let configuration = URLSessionConfiguration.default
  let session =  URLSession(configuration: configuration)
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  let task = session.dataTask(with: request) { (data, response, error) in
    guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else {return}
    print(json)
  }
  task.resume()
  webView.load(request)
  return ()
}

func vkPrintDataToConsoleSearch(urlComponents : URLComponents) {
  guard let url = urlComponents.url else {return}
  let configuration = URLSessionConfiguration.default
  let session =  URLSession(configuration: configuration)
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  let task = session.dataTask(with: request) { (data, response, error) in
    guard let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) else {return}
    print(json)
  }
  task.resume()
  return ()
}
