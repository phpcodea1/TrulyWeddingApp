//
//  HeaderGuestListTableCell.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class HeaderGuestListTableCell: UITableViewCell {

    @IBOutlet weak var CoupleLabel: UILabel!
    @IBOutlet weak var GuestLabel: UILabel!
    @IBOutlet weak var HeaderBtn: UIButton!
    
    @IBOutlet var AllClick: UIButton!
    @IBOutlet var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
