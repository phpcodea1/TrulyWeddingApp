//
//  EditGuestOptionTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 31/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class EditGuestOptionTableViewCell: UITableViewCell {

    @IBOutlet var selectedOptionBtn: UIButton!
    @IBOutlet var backView: UIView!
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
