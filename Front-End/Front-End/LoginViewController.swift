//
//  LoginViewController.swift
//  Front-End
//
//  Created by Niranjan Kumar on 4/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    enum LoginType {
        case signUp
        case signIn
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var apiController: APIController?
    var loginType = LoginType.signUp
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func test(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let apiController = apiController else { return }
        
//        if loginType == .signUp use ibaction for segment
        if segmentedControl.selectedSegmentIndex == 0{
            if let username = username.text, !username.isEmpty, let password = password.text, !password.isEmpty {
                let user = SignUpUser(username: username, password1: password, password2: password)
                
                apiController.registerAndSignIn(with: user) { (error) in
                    if let error = error {
                        print("Error occured during register & sign in \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: "Sign Up Successful", message: "You'll now be logged in!", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "Great", style: .default) { (_) in
                                self.dismiss(animated: true, completion: nil)
                            }
                            
                            alertController.addAction(alertAction)
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            }
        } else {
            if let username = username.text, !username.isEmpty, let password = password.text, !password.isEmpty {
                let user = LoginUser(username: username, password: password)
                
                apiController.signIn(with: user) { (error) in
                    if let error = error {
                        print("Error occured during sign in \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}
