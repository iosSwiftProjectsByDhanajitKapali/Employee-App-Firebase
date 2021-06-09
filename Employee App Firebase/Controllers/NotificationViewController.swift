//
//  NotificationViewController.swift
//  Employee App Firebase
//
//  Created by unthinkable-mac-0025 on 21/05/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController , UITableViewDataSource{
   

    @IBOutlet var notificationTableView: UITableView!
    
    var notifications : [Notification] = [
        Notification(title: "Notification 1", body: "this is a test notification"),
        Notification(title: "Notification 1", body: "this is a test notification"),
        Notification(title: "Notification 1", body: "this is a test notification"),
        Notification(title: "Notification 1", body: "this is a test notification"),
        Notification(title: "Notification 1", body: "this is a test notification")
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationTableView.dataSource = self
        
        //registering the nib in the tableView
        notificationTableView.register(UINib(nibName: K.notificationNibName, bundle: nil), forCellReuseIdentifier: K.notificationCellIdentifier)
        
        //adding pull to refresh in the UITableView
        notificationTableView.refreshControl = UIRefreshControl()
        notificationTableView.refreshControl?.attributedTitle = NSAttributedString(string: "Fetching Notifications")
        notificationTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc
    func pullToRefresh(){
        print("Fetching Notifications")
        notificationTableView.refreshControl?.endRefreshing()
        notificationTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = notificationTableView.dequeueReusableCell(withIdentifier:K.notificationCellIdentifier , for: indexPath) as! NotificationCell
        
        cell.notificationTitle?.text = notifications[indexPath.row].title
        cell.notificationBody.text = notifications[indexPath.row].body
        
        return cell
    }
    
    

}
