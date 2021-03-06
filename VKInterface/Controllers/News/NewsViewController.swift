//
//  NewsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 08.12.2021.
//

import UIKit
import Alamofire
import FirebaseAuth


final class NewsViewController: UIViewController {
  
  @IBOutlet weak var firstItem: UIView!
  @IBOutlet weak var firstItemCenter: UIView!
  @IBOutlet weak var secondItem: UIView!
  @IBOutlet weak var secondItemCenter: UIView!
  @IBOutlet weak var thirdItem: UIView!
  @IBOutlet weak var thirdItemCenter: UIView!
  @IBOutlet weak var singletonButton: UIButton!
  @IBOutlet weak var groupSearch: UITextField!
  @IBOutlet weak var groupSearchButton: UIButton!
  
  let networkServices = NetworkServices()
  let shared = Session()
  
  private func loadingAnimation(times: Int, counter: Int) {
    
    let timeInteval: Double = 1
    
    firstItem.alpha = 0
    secondItem.alpha = 0
    thirdItem.alpha = 0
    firstItemCenter.alpha = 0
    secondItemCenter.alpha = 0
    thirdItemCenter.alpha = 0
    
    UIView.animate(withDuration: timeInteval) { [weak self] in
      self?.firstItem.alpha = 1
      self?.firstItem.layer.cornerRadius = 15
      self?.firstItem.alpha = 0.25
      self?.firstItemCenter.alpha = 1
      self?.secondItem.alpha = 0
      self?.secondItemCenter.alpha = 0
    } completion: { _ in
      UIView.animate(withDuration: timeInteval) { [weak self] in
        self?.secondItem.alpha = 1
        self?.secondItem.layer.cornerRadius = 15
        self?.secondItem.alpha = 0.25
        self?.secondItemCenter.alpha = 1
        self?.firstItem.alpha = 0.125
      } completion: { _ in
        UIView.animate(withDuration: timeInteval) { [weak self] in
          self?.thirdItem.alpha = 1
          self?.thirdItem.layer.cornerRadius = 15
          self?.thirdItem.alpha = 0.25
          self?.thirdItemCenter.alpha = 1
          self?.secondItem.alpha = 0.125
          self?.firstItem.alpha = 0
          self?.firstItemCenter.alpha = 0
        } completion: { [weak self] _ in
          if counter < times {
            self?.loadingAnimation(times: times, counter: counter + 1)
          }
          else {
            self?.firstItem.alpha = 1
            self?.secondItem.alpha = 1
            self?.thirdItem.alpha = 1
            self?.firstItemCenter.alpha = 1
            self?.secondItemCenter.alpha = 1
            self?.thirdItemCenter.alpha = 1
          }
        }
      }
    }
  }
  
  private func loadingAnimationKeyFrame(times: Int, counter: Int) {
    let durationAnimation: CGFloat = 3
    firstItem.alpha = 0
    secondItem.alpha = 0
    thirdItem.alpha = 0
    firstItemCenter.alpha = 0
    secondItemCenter.alpha = 0
    thirdItemCenter.alpha = 0
    
    UIView.animateKeyframes(withDuration: durationAnimation,
                            delay: 0,
                            options: [.repeat, .autoreverse]) { [weak self] in
      UIView.addKeyframe(withRelativeStartTime: 0,
                         relativeDuration: 1 / 3) {
        self?.firstItem.alpha = 1
        self?.firstItem.layer.cornerRadius = 15
        self?.firstItem.alpha = 0.5
        self?.firstItemCenter.alpha = 1
        self?.secondItem.alpha = 0
        self?.secondItemCenter.alpha = 0
      }
      UIView.addKeyframe(withRelativeStartTime: 1 / 3,
                         relativeDuration: 1 / 3) {
        self?.secondItem.alpha = 1
        self?.secondItem.layer.cornerRadius = 15
        self?.secondItem.alpha = 0.5
        self?.secondItemCenter.alpha = 1
        self?.firstItem.alpha = 0.125
      }
      UIView.addKeyframe(withRelativeStartTime: 2 / 3,
                         relativeDuration: 1 / 3) {
        self?.thirdItem.alpha = 1
        self?.thirdItem.layer.cornerRadius = 15
        self?.thirdItem.alpha = 0.5
        self?.thirdItemCenter.alpha = 1
        self?.secondItem.alpha = 0.125
        self?.firstItem.alpha = 0
        self?.firstItemCenter.alpha = 0
      }
    } completion: { _ in
    }
  }
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadingAnimationKeyFrame(times: 5, counter: 0)
    print(shared.token)
  }
  
  @IBAction func toSingletonView(_ sender: Any) {
  }
  
  @IBAction func groupSearchButton(_ sender: Any) {
    networkServices.vkGroupSearch(searchText: groupSearch.text ?? "")
  }
  
  @IBAction func toObserverPatternVC(_ sender: Any) {
  }
  
  
  @IBAction func logOut(_ sender: Any) {
    do {
      try Auth.auth().signOut()
    } catch let (error) {
      print("\(error)")
    }
  }
}
