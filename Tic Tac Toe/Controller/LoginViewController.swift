//
//  LoginViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 1/28/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import Leanplum
import os.log

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    var userLogin: String!
    var password: String!
    var onboard:Bool = false
    
    var login: Login?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.delegate = self
        emailAddress.delegate = self

        
        Leanplum.forceContentUpdate()
        
        Leanplum.onVariablesChanged {
            
            self.onboard = (onboardTrack?.boolValue())!
            print("onboard is: \(self.onboard)")
            
            if self.onboard {
                let onboardVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OnboardViewController") as! OnboardPageViewController
                if let vc = UIApplication.shared.keyWindow?.rootViewController {
                    vc.show(onboardVC, sender: (Any).self)
                    self.onboard = false
                }
            }

            self.signInButton.layer.cornerRadius = (btnRadius?.cgFloatValue())!
            self.signUpButton.layer.cornerRadius = (btnRadius?.cgFloatValue())!
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameField.resignFirstResponder()
        emailAddress.resignFirstResponder()
        
        return true
    }


    @IBAction func signinButton(_ sender: UIButton) {
    
        userLogin = usernameField.text
        password = emailAddress.text

    
        if (userLogin.isEmpty == false && password.isEmpty == false) {

            
            Leanplum.setUserId(userLogin)
            Leanplum.forceContentUpdate()
            
            print("Login is Successful: \(userLogin)")
            
            performSegue(withIdentifier: "gameSegue", sender: nil)
            
        }
        else if (userLogin.isEmpty || password.isEmpty) {
            let alert = UIAlertController(title: "Sign In", message: "All Fields Are Required", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Oops", message: "Your account can't be found", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }

        print("LoginViewController")
        
    }
    
    @IBAction func regButton(_ sender: Any) {
        
        performSegue(withIdentifier: "regSegue", sender: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameSegue" {
            let nextViewController = segue.destination as! GameViewController
            nextViewController.userLogin = usernameField.text!

        }
        else {
            
            let nextViewController = segue.destination as! SignUpViewController
            
        }
    }


}

