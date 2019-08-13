//
//  AllWeddingShowTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 28/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AllWeddingShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var preRegisterBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var weddingTitle: UILabel!
    @IBOutlet weak var shadowView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
