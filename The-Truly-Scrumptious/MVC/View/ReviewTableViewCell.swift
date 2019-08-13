//
//  ReviewTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
