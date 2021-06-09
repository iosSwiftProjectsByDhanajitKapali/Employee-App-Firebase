//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var organizationTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var creatteAccountOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        creatteAccountOutlet.layer.cornerRadius = 20
    }
    
  
    @IBAction func createAccountBtn(_ sender: UIButton) {
        if let name = nameTextfield.text, let email = emailTextfield.text, let organiztion = organizationTextfield.text, let password = passwordTextfield.text{
            
            //adding data to the firestore database
            db.collection("users").addDocument(data: [
                "FStorename" : "\(name)",
                "FStoreEmail" : "\(email)",
                "FStoreOrganization" : "\(organiztion)"
            ]){ (error) in
                if let e = error {
                    print("There was an error saving the Data to the Firebase,\(e)")
                }else{
                    print("Data saved Successfully to the Firestore")
                    
                    //creating an user with entered email and password
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let e = error{
                            print(e)
                        }else{
                            //no error while creating new user
                            print("no error while creating new user")
                            
                            //creating an alert
                            let alert = UIAlertController(title: "Registered Succesfully", message: "", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Done", style: .default) { (action) in
                                //navigate to home Screen
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
                
            }
            
        }
        
    }
    
}
