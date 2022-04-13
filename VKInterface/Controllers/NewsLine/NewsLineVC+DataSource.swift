//
//  NewsLineVC+DataSource.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.02.2022.
//

import UIKit

extension NewsLineVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.count ?? 0
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentificator,
                                                   for: indexPath) as? NewsLineTVC,
          let news = news[indexPath.row] else { return UITableViewCell() }
    cell.configure(news: news)
    
    return cell
    
  }
}
