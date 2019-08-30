//
//  PhotoButtomHeaderTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 01/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class PhotoButtomHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var venue3: UILabel!
    @IBOutlet weak var venue2: UILabel!
    
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var venue1: UILabel!
    
    @IBOutlet weak var bookMarkView: UIView!
    @IBOutlet weak var ShortView: UIView!
    
    @IBOutlet weak var ReviewView: UIView!
    @IBOutlet weak var VenueTextView: UIView!
    @IBOutlet weak var VenuePhoneView: UIView!
    
    @IBOutlet weak var VenueEmailView: UIView!
    
    
    
    
    @IBOutlet weak var BookMark: UIButton!
    @IBOutlet weak var ShortList: UIButton!
    @IBOutlet weak var Review: UIButton!
    @IBOutlet weak var VenueText: UIButton!
    @IBOutlet weak var VenuePhone: UIButton!
    @IBOutlet weak var VenueEmail: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
