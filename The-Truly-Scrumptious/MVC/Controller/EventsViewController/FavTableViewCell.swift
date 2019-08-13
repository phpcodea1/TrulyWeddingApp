//
//  FavTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 05/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var totalLbl: UILabel!
    
    @IBOutlet weak var ratingUIView: FloatRatingView!
    @IBOutlet weak var locationlbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
