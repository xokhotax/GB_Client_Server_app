//
//  NewsLineTVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.02.2022.
//

import UIKit

class NewsLineTVC: UITableViewCell {

  @IBOutlet weak var newsImage: UIImageView!
  @IBOutlet weak var data: UILabel!
  @IBOutlet weak var author: UILabel!
  @IBOutlet weak var newsText: UILabel!
  @IBOutlet weak var comments: UILabel!
  @IBOutlet weak var likes: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }
  
  func configure(news: News) {
    
    newsText.text = String(describing: news.text.description)
  }
}
