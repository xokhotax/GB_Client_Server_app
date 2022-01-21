//
//  FireBaseLoginVC.swift
//  VKInterface
//
//  Created by Ivan Okhota on 21.01.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FireBaseLoginVC: UIViewController {
  
  @IBOutlet weak var loginTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var registrationButton: UIButton!
  
  private var handle: AuthStateDidChangeListenerHandle!
  
  private let alertController = UIAlertController(title: "Зарегистрировать",
                                                  message: "Провести регистрацию пользователя",
                                                  preferredStyle: .actionSheet)
  
  private let alertMissedData = UIAlertController(title: "Ошибка",
                                                  message: "Проверьте логин и пароль",
                                                  preferredStyle: .alert)
  
  private let actionOK = UIAlertAction (title: "OK", style: .cancel)
  private let actionNo = UIAlertAction (title: "Нет", style: .cancel)
  
  private let base = Firestore.firestore()
  private let collection = "geekBrain"
  
  
  private func messageWithServerError(error: Error){
    let loginMissedData = UIAlertController(title: "Ошибка",
                                            message: error.localizedDescription,
                                            preferredStyle: .alert)
    loginMissedData.addAction(self.actionOK)
    self.present(loginMissedData, animated: true)
  }
  
  private func registrationFireBase() -> UIAlertAction {
    let actionYes = UIAlertAction(title: "Да", style: .default) {[weak self] _ in
      guard let self = self,
            let emailLogin = self.loginTextField.text,
            let password = self.passwordTextField.text else { return }
      
      if emailLogin.count > 0, password.count > 0 {
        Auth.auth().createUser(withEmail: emailLogin, password: password)
      } else {
        self.present(self.alertMissedData, animated: true)
      }
    }
    return actionYes
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    alertController.addAction(actionNo)
    alertMissedData.addAction(actionOK)
    alertController.addAction(registrationFireBase())
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Auth.auth().removeStateDidChangeListener(handle)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self .handle = Auth.auth().addStateDidChangeListener {[weak self] auth, user in
      guard let self = self else { return }
      if user != nil {
        self.performSegue (withIdentifier: goToVKLogin , sender: nil )
        self.loginTextField.text = nil
        self.passwordTextField.text = nil
      }
    }
  }
  
  @IBAction func loginButton(_ sender: UIButton) {
    guard let emailLogin = loginTextField.text,
          let password = passwordTextField.text,
          emailLogin.count > 0,
          password.count > 0 else {
            present(alertMissedData, animated: true)
            return
          }
    Auth.auth().signIn(withEmail: emailLogin, password: password) { [weak self] user, error in
  
      guard let user = user else { return }
      
      let model = UserFireBase(email: emailLogin, iD: user.user.uid, groupName: nil)
      guard let data = try? JSONEncoder().encode(model),
            let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
            let self = self
      else { return }
      
      let usersFBSingleton = UsersFBSingleton.shared
      usersFBSingleton.uid = user.user.uid
      usersFBSingleton.email = emailLogin
      
      self.base.collection(_:self.collection).document(UsersFBSingleton.shared.uid).setData(dict, merge: true)
      
      if let error = error {
        self.messageWithServerError(error: error)
      }
    }
  }
  
  @IBAction func registrationButton(_ sender: UIButton) {
    present(alertController, animated: true)
  }
  
  
  
}

