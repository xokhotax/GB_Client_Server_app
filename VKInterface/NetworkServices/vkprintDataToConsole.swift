//
//  vkprintDataToConsole.swift
//  VKInterface
//
//  Created by Ivan Okhota on 24.12.2021.
//

import Foundation

func vkPrintDataToConsole(urlComponents : URLComponents) {
  guard let url = urlComponents.url else { return }
  let configuration = URLSessionConfiguration.default
  let session =  URLSession(configuration: configuration)
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  let task = session.dataTask(with: request) { (data, response, error) in
    guard let data = data,
          let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) else { return }
    print(json)
    
  }
  task.resume()
  return ()
}
