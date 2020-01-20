//
//  SignUpViewController.swift
//  Leanplum Game Demo - Tic Tac Toe
//
//  Created by Zach Owens on 2/27/19.
//  Copyright © 2019 Zach Owens. All rights reserved.
//

import UIKit
import Leanplum

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var otherField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!

    
    var username:String!
    var email: String!
    var firstName:String!
    var lastName: String!
    var age: String!
    var other: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameField.delegate = self
        emailField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        ageField.delegate = self
        otherField.delegate = self
        
        submitButton.layer.cornerRadius = 4.0

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        ageField.resignFirstResponder()
        otherField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func registrationSubmit(_ sender: UIButton) {
        
        username = usernameField.text
        email = emailField.text
        firstName = firstNameField.text
        lastName = lastNameField.text
        age = ageField.text
        other = otherField.text
        
        if (username.isEmpty || email.isEmpty || firstName.isEmpty || lastName.isEmpty || age.isEmpty) {
            
            let alert = UIAlertController(title: "Register", message: "These Fields Are Required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else {
            
            Leanplum.setUserId(username)
            Leanplum.setUserAttributes(["email" : email!, "firstName": firstName!, "lastName": lastName!, "age": age!, "other": other!] )
            
            Leanplum.track("Registered")
            
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! LoginViewController
            if let vc = UIApplication.shared.keyWindow?.rootViewController {
                Leanplum.forceContentUpdate()
                vc.show(loginVC, sender: (Any).self)
            }
            
            usernameField.text?.removeAll()
            passwordField.text?.removeAll()
            emailField.text?.removeAll()
            firstNameField.text?.removeAll()
            lastNameField.text?.removeAll()
            ageField.text?.removeAll()
            otherField.text?.removeAll()
            
        }

    }
    

}
