//
//  BudgetTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class BudgetTableViewCell: UITableViewCell {

  
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
