//
//  PhotoHeaderTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 01/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class PhotoHeaderTableViewCell: UITableViewCell
{
    @IBOutlet weak var arraowBtn: UIButton!
    
    @IBOutlet weak var buttomLine: UIView!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
