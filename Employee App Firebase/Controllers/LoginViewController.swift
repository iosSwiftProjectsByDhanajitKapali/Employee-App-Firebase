//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text , let password = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print("There was error Authenticating the user\(e)")
                    //creating an alert
                    let alert = UIAlertController(title: "Invalid User Id Or Password", message: "", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default) { (action) in
                        //navigate to home Screen
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }else{
                    //firebase authenticated the loginDetails
                    //now move to the Details section
                    self.performSegue(withIdentifier:"LoginToDetails", sender: self)
                }
              
            }
        }
    }
    
}
