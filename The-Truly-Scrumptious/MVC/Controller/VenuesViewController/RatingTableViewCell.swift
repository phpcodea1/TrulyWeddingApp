//
//  RatingTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 02/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var reviewTxt: UILabel!
    @IBOutlet weak var rating: FloatRatingView!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
