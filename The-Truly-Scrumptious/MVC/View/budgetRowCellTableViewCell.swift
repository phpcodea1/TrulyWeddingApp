//
//  budgetRowCellTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class budgetRowCellTableViewCell: UITableViewCell {

    @IBOutlet var topLineView: UIView!
    
    @IBOutlet var costLbl: UILabel!
    @IBOutlet var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
