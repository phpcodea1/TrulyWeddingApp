//
//  AllEventTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 13/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AllEventTableViewCell: UITableViewCell {

    @IBOutlet var weddingUIView: UIView!
    @IBOutlet var celeProfileImg: UIImageView!
    
    @IBOutlet var selectButton: UIButton!
    @IBOutlet var celeUiView: UIView!
    
    @IBOutlet var wedSecImg: UIImageView!
    @IBOutlet var wedFirstImg: UIImageView!
    
    @IBOutlet var eventTypeLbl: UILabel!
    
    @IBOutlet var eventDateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
