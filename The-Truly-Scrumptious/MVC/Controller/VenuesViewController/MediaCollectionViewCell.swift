//
//  MediaCollectionViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 02/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var mediaType: UILabel!
    @IBOutlet weak var mediaName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
