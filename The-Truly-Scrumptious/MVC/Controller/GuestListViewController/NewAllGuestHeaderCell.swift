//
//  NewAllGuestHeaderCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewAllGuestHeaderCell: UITableViewCell {
    
    @IBOutlet weak var bottomLine: UIView!
    
    @IBOutlet weak var topLine: UIView!
    
    @IBOutlet weak var editBtn: UIButton!
    
    @IBOutlet weak var deleteBtn: UIButton!
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
