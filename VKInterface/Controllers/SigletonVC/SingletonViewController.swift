//
//  SingletonViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.12.2021.
//

import UIKit

final class SingletonViewController: UIViewController {
  
  @IBOutlet weak var textFieldOne: UILabel!
  @IBOutlet weak var textFieldTwo: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let session = Session.shared
    textFieldOne.text = session.token
    textFieldTwo.text = String(session.userId)
    
  }
  
}
