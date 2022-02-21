//
//  NewsLineVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.02.2022.
//

import UIKit

class NewsLineVC: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
        super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UINib(nibName: "NewsLineTVC", bundle: nil),
                       forCellReuseIdentifier: secondCellReuseIdentificator)
    tableView.reloadData()
    
    
    }
    


}
