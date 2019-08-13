//
//  Check_Done_TableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class Check_Done_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var timingLabel: UILabel!
    
    @IBOutlet weak var crossView: UIView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var checkView: UIView!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var checkDoneLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
