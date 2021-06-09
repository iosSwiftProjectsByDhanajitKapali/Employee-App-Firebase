//
//  NotificationCell.swift
//  Employee App Firebase
//
//  Created by unthinkable-mac-0025 on 21/05/21.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {

    @IBOutlet var notificationTitle: UILabel!
    @IBOutlet var notificationDate: UILabel!
    @IBOutlet var notificationBody: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
