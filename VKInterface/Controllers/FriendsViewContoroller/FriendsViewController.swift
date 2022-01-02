//
//  FriendsViewController.swift
//  VKInterface
//
//  Created by Ivan Okhota on 28.11.2021.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarFriend: UISearchBar!
  
  weak var delegate: FriendsDataLoad?
  
  let cellReuseIdentificator = "cellReuseIdentificator"
  let toGallerySeague = "toGallerySeague"
  var friendsArray = [Friends]()
  
  var usersArray = [UsersListResponse]()
  
  private func vkFriendsList(_ completion: @escaping (UsersListResponse) -> Void ) {
    
    let userId = Session.shared.userId
    let token = Session.shared.token
    let host = "https://api.vk.com"
    let path = "/method/friends.get"
    
    let url = URL(string: host + path)!
    let parameters = [
      "access_token" : token,
      "owner_id" : userId,
      "order" : "hints",
      "fields" : "photo_200_orig",
      "name_case" : "nom",
      "v" : "5.131"
    ]
    AF.request(url, parameters: parameters).responseDecodable{ (response: AFDataResponse<UsersListResponse>)  in
      guard let response = response.value else { return }
      completion(response)
    } .resume()
  }
  
  ////    let friendsData = FriendsData.shared.sourceFriendsArray
  
  override func viewDidLoad() {
    super.viewDidLoad()
    searchBarFriend.delegate = self
    tableView.dataSource = self
    tableView.delegate = self
    FriendsData.shared.delegate = self
    
    vkFriendsList()
    { response in
      
      self.usersArray.append(response)
      print("Финальный массив \(self.usersArray)")
      
    }
    
    tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil),
                       forCellReuseIdentifier: cellReuseIdentificator)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(addNewUser(_ :)),
                                           name: Notification.Name("addNewUserButton"),
                                           object: nil)
        FriendsData.shared.fillFriendsData()
        friendsArray = FriendsData.shared.sourceFriendsArray
    tableView.reloadData()
  }
  
  @objc func addNewUser (_ notification: Notification) {
    guard let groupObject = notification.object as? Friends else { return }
    friendsArray.append(groupObject)
    tableView.reloadData()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}


