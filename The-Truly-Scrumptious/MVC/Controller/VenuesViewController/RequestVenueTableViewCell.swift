//
//  RequestVenueTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 06/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class RequestVenueTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var messagelbl: UILabel!
    @IBOutlet weak var locaLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var imag: UIImageView!
    
    @IBOutlet weak var satuslabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
