//
//  VenuePriceTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class VenuePriceTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var pricingimage: UIImageView!
    
    @IBOutlet weak var pricingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
