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
    textFieldOne.text = "User Token: \(Session.shared.token)"
    textFieldTwo.text = "UserID: \(Session.shared.userId)"
    
  }
  
}
