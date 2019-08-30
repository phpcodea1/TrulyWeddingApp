//
//  PhotoFirstSectTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 01/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class PhotoFirstSectTableViewCell: UITableViewCell {

    
        @IBOutlet weak var hotelTitleLbl: UILabel!
        @IBOutlet weak var venueTypeLbl: UILabel!
        @IBOutlet weak var seatLbl: UILabel!
        @IBOutlet weak var addressLbl: UILabel!
        @IBOutlet weak var emailLbl: UILabel!
    
        @IBOutlet weak var LongImg: UIImageView!
        @IBOutlet weak var tellPhoneLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    
    
        @IBOutlet weak var ovrVenueType: UILabel!
    
        @IBOutlet weak var ovrEveningCap: UILabel!
    
        @IBOutlet weak var ovrBedCap: UILabel!
    
        @IBOutlet weak var ovrSleepLbl: UILabel!
    
        @IBOutlet weak var ovrAward: UILabel!
    
        @IBOutlet weak var ovrInsuLbl: UILabel!
    
        @IBOutlet weak var ovrQalifLbl: UILabel!
        @IBOutlet weak var ovtProfMem: UILabel!
    @IBOutlet weak var totalNoOfRating: UILabel!
    
    
    @IBOutlet weak var ratingUIView: FloatRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
