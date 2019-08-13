//
//  CellGuestListTableViewCell.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class CellGuestListTableViewCell: UITableViewCell {

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
