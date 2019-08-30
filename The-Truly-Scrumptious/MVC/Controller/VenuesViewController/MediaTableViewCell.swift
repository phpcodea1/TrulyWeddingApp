//
//  MediaTableViewCell.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 02/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MediaTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    var playerviewcontroller = AVPlayerViewController()
    var playerview = AVPlayer ()

    @IBOutlet weak var nofoundLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttomView: UIView!
    var collectionArray = NSArray()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
         collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCollectionViewCell")
    }

    func load(array:NSArray)
    {
        self.collectionArray = array
        self.collectionView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MediaCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MediaCollectionViewCell")
        // Configure the view for the selected state
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MediaCollectionViewCell", for: indexPath) as! MediaCollectionViewCell
        let dict = self.collectionArray.object(at: indexPath.row) as! NSDictionary
    
       var mediaType = dict.value(forKey: "media_type") as! String
        
        
        if mediaType == "image"
        {
            cell.playBtn.isHidden = true
            if let media_file = dict.value(forKey: "media_file") as? String
            {
                if media_file != ""
                {
                    let url = URL(string: media_file)!
                    cell.image.sd_setImage(with: url, completed: nil)
                }
                
            }
        }
        else
        {
            cell.playBtn.isHidden = false
              var media_file = dict.value(forKey: "media_file") as! String
            let url = URL(string: media_file)!
            
            DispatchQueue.main.async {
                
            }
            if let thumbnailImage = getThumbnailImage(forUrl: url)
            {
                cell.image.image = thumbnailImage
            }
            
        }
        
       
        cell.playBtn.tag = indexPath.row
        
        cell.playBtn.addTarget(self, action: #selector(PlayVideoClick), for: .touchUpInside)
       
        
        return cell
    }
    
    
    @objc func PlayVideoClick(_ sender:UIButton)
    {
        let dict = self.collectionArray.object(at: sender.tag) as! NSDictionary
        
        var media_file = dict.value(forKey: "media_file") as! String
        
        DEFAULT.set(media_file, forKey: "media_file")
        DEFAULT.synchronize()
        
        NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
//        var fileURL = URL(fileURLWithPath:"/Users/MorganEvans/Documents/Apps/Warm Up/Video View/Video View/ViewController.swift")
//        playerview = AVPlayer(url: fileURL)
//
//        playerviewcontroller.player = playerview
//
//
//        self.pre(playerviewcontroller, animated: true){
//
//
//            self.playerviewcontroller.player?.play()
//        }
        
    }
    
    func getThumbnailImage(forUrl url: URL) -> UIImage?
    {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        
        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }
        
        return nil
    }
}

