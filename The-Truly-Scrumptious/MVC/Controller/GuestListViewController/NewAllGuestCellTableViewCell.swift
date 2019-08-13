//
//  NewAllGuestCellTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewAllGuestCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftConst: NSLayoutConstraint!
    @IBOutlet weak var NotificationImage: UIImageView!
    @IBOutlet weak var PartnerLabel: UILabel!
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
