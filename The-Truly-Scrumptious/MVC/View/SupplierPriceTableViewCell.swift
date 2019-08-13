//
//  SupplierPriceTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 24/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SupplierPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    @IBOutlet weak var images: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
