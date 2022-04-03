//
//  NewsLineVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.02.2022.
//

import UIKit
import RealmSwift

class NewsLineVC: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  var news = [News?]()
  private let networkServices = NetworkServices()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    networkServices.vkNewsFeed { result in
      switch result {
        case let .failure(error):
          print(error)
        case let .success(news):
          self.news = news
          self.tableView.reloadData()
          print(news)
      }
    }
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "NewsLineTVC", bundle: nil),
                       forCellReuseIdentifier: secondCellReuseIdentificator)
    tableView.reloadData()
    
    
  }
  
  
  
}
