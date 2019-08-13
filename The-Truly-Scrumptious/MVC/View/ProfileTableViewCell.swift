//
//  ProfileTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var topView: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
