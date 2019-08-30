//
//  NotificationTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 30/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
