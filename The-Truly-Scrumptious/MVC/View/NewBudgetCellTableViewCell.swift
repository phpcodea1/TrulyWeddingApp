//
//  NewBudgetCellTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewBudgetCellTableViewCell: UITableViewCell {
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet var lineView: UIView!
    @IBOutlet weak var arrowBtn: UIButton!
     @IBOutlet weak var arrowBtn2: UIButton!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
