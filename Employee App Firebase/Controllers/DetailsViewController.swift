//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    let db = Firestore.firestore()
    var user : String?
    
    @IBOutlet weak var detailsTextview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hiding the back button in the chat screen
        navigationItem.hidesBackButton = true
        
        //loadDetails()
        
        user = Auth.auth().currentUser?.email
        loadDetails()
        
    }
    
    
   
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            //jumpt to root screen , in the stack view
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func loadDetails()  {
        //getting data from the Firestore DB
        db.collection("users").getDocuments { (querySnapshot, error) in
            if let e = error{
                print("There was an issue retrieving data from the Firestore\(e)")
            }else{
                if let snapShotDocuments = querySnapshot?.documents{
                    for doc in snapShotDocuments{
                        let data = doc.data()
                        if data["FStoreEmail"] as? String == self.user{
                            //print(data["FStorename"])
                            
                            let detailsText : String = " Name = \(data["FStorename"]!) \n Email = \(data["FStoreEmail"]!) \n Organization = \(data["FStoreOrganization"]!)"
                            
                            print(detailsText)
                           self.detailsTextview.text = detailsText
                        }
                       
                    }
                }
            }
        }
    }
    
}
