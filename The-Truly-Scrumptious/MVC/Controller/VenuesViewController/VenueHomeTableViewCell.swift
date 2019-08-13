//
//  VenueHomeTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class VenueHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingUiView: FloatRatingView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var amountLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var reviewLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var LongImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
