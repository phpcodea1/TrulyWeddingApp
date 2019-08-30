//
//  NoticeTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    @IBOutlet weak var leftConst: NSLayoutConstraint!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var datelbl: UILabel!
    
    @IBOutlet weak var commentTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
