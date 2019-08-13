//
//  AllGuestTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AllGuestTableViewCell: UITableViewCell {
    @IBOutlet weak var thirdLbl: UILabel!
    @IBOutlet weak var firstLbl: UILabel!
    @IBOutlet weak var secondLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
