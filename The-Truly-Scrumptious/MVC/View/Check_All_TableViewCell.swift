//
//  Check_All_TableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class Check_All_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var crossView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var checlAllLabel: UILabel!
    
    @IBOutlet weak var hideView: UIView!
    
    @IBOutlet weak var timingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
