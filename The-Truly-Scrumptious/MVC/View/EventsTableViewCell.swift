//
//  EventsTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 28/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: CardView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var weddingImages: UIImageView!
    @IBOutlet weak var weddingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectButton.layer.shadowColor = UIColor.darkGray.cgColor
        selectButton.layer.shadowOpacity = 0.7
        selectButton.layer.shadowOffset = CGSize.zero
        selectButton.layer.shadowRadius = 5
        selectButton.layer.shadowPath = UIBezierPath(rect: selectButton.bounds).cgPath
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
