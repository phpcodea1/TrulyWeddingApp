//
//  NewExpenseTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewExpenseTableViewCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet var Lbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
