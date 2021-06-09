//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseRemoteConfig

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //fatalError()
       
        //checkIfCatOrDogPerson()
        //fetchValues()
        
    }
    
    //MARK: - Firebase Analytics
    
    //setting user properties
    func dogPersonHandler(_:UIAlertAction) {
        Analytics.setUserProperty("dog_person", forName: "dog_or_cat")
    }
    func catPersonHandler(_:UIAlertAction)  {
        Analytics.setUserProperty("cat_person", forName: "dog_or_cat")
    }
    
    func checkIfCatOrDogPerson(){
        let alert = UIAlertController(title: "Are You a Dog Person, or a Cat Person", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dog Person", style: .default, handler: dogPersonHandler))
        alert.addAction(UIAlertAction(title: "Cat Person", style: .default, handler: catPersonHandler))
        present(alert, animated: true)
    }
    
    
    //Loging events to the Firebase Analytics
    @IBAction func registerBtnPressed(_ sender: UIButton) {
        Analytics.logEvent("register_btn_pressed", parameters: nil)
    }
    
    //MARK: - Remote Congfig
    func fetchValues()  {
        
        // setting default value for welcome_label
        let defaults: [String : NSObject] = [
            "welcome_label" : false as NSObject
        ]
        remoteConfig.setDefaults(defaults)
        
        //setting fetch interval from Remote Config
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        
        //getting value from cache
        let cachedValue = self.remoteConfig.configValue(forKey: "welcome_label").boolValue
        self.updateUI(toHide: cachedValue)
        
        //fetching value from remote, and setting expiry time of cached value
        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { status, error in
            if status == .success, error == nil{
                self.remoteConfig.activate(completion: {changed, error  in
                    guard error == nil else{
                        return
                    }
                    
                    let value = self.remoteConfig.configValue(forKey: "welcome_label").boolValue
                    print("Fetched \(value)")
                    DispatchQueue.main.async {
                        self.updateUI(toHide: value)
                    }
                    
                })
            }else{
                print("Error Fetching Data from Remote Config")
            }
        })
    }
    
    func updateUI(toHide : Bool) {
        print("Fetched \(toHide)")
        titleLabel.isHidden = toHide
    }
    


}
