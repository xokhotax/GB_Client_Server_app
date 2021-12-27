//
//  ObserverVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 27.12.2021.
//

import UIKit

class ObserverVC: UIViewController, Subscriber {
  
  @IBOutlet weak var obserrverCounterLabel: UILabel!
  
  var reporter = Reporter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    reporter.subscribe(self)
  }
  
  @IBAction func publishButton(_ sender: Any) {
    reporter.releaseVideo()
  }
  
  func update(subject: Reporter) {
    obserrverCounterLabel.text = subject.counterInfo
  }
}

//MARK:- Protocols
protocol Subscriber : UIViewController {
  func update(subject : Reporter )
}

struct WeakSubscriber {
  weak var value : Subscriber?
}

class Reporter {
  
  private lazy var subscribers : [WeakSubscriber] = []
  
  var counter : Int = 0
  var counterInfo = ""
  
  func subscribe(_ subscriber: Subscriber) {
    print("subscribed")
    subscribers.append(WeakSubscriber(value: subscriber))
  }
  
  func notify() {
    subscribers.forEach { $0.value?.update(subject: self)
    }
  }
  
  func releaseVideo() {
    counter += 1
    counterInfo = "Times button pushed" + "\(counter)"
    notify()
    print("Pushed!")
  }
}
