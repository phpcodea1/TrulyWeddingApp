//
//  PinBoardViewController.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import UIKit
import ObjectMapper
import AVKit
import AVFoundation
import FloatRatingView
import MessageUI
import Messages

class PinBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate
{
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    
    
    
    var imageArray = [String]()
    var nameArray = [String]()
    var mainArray = NSMutableArray()
    // for video play
    
    var playerviewcontroller = AVPlayerViewController()
    var playerview = AVPlayer ()
    
    var playerViewController=AVPlayerViewController()
    
    var playerView = AVPlayer()
    
    @IBOutlet weak var pinCollection: UICollectionView!
    
    var pinID = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       
        
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            AllPinBoardAPI()
        }
        
        nodataLbl.isHidden = true
        
         pinCollection.register(UINib(nibName: "AddPinCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPinCollectionViewCell")
    imageArray = ["1-1","3","pic1","pic2","5","pic2","pic3","pic4","pic3","5","pic1","5","pic3","5"]
    nameArray = [" title1"," title2"," title3"," title4"," title5"," title6"," title7"," title8"," title9"," title10"," title11"," title12"," title13"," title14"]
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        
       
        if let yes = DEFAULT.value(forKey: "FromUpload") as? String
        {
            DEFAULT.removeObject(forKey: "FromUpload")
            DEFAULT.synchronize()
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                
                AllPinBoardAPI()
            }
        }
        
    }
   
  
    @objc func ImageClick()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsPinBoardViewController") as! DetailsPinBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BackAct(_ sender: UIButton)
    {
  self.navigationController?.popViewController(animated: true)
    }
    @IBAction func startBtnAct(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewAddPinBoaardViewController") as! NewAddPinBoaardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return imageArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeddingSupplierTableViewCell") as? WeddingSupplierTableViewCell
//        //cell?.dataLabel.text = imageArray[indexPath.item]
//        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
//
//
//        return cell!
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPinCollectionViewCell", for: indexPath) as! AddPinCollectionViewCell
        
        cell.img.layer.cornerRadius = 10
        cell.img.clipsToBounds = true
        
        cell.editBtn.clipsToBounds = true
        cell.editBtn.layer.cornerRadius = 10
        cell.editBtn.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        var dict = self.mainArray.object(at: indexPath.row) as! NSDictionary
       
        if let  imageData = dict.value(forKey: "fileName") as? String
        {
            if imageData != ""
            {
                var baseUrl = liveImageBaseURL + imageData
                let url = URL(string: baseUrl)
                cell.img.sd_setImage(with: url, completed: nil)
               
            }
            
        }
//        if let  imageData = dict.value(forKey: "fileName") as? String
//        {
//           cell.editBtn.setTitle(imageData, for: .normal)
//        }
       cell.editBtn.isHidden = true
        
        if let  imageData = dict.value(forKey: "fileType") as? String
        {
            if imageData == "i"
            {
                cell.platBtn.isHidden = true
            }
            else
            {
                if let  imageData = dict.value(forKey: "fileName") as? String
                {
                    if imageData != ""
                    {
                       DispatchQueue.global(qos: .userInitiated).async
                            {
                            var baseUrl = liveImageBaseURL + imageData
                            let url = URL(string: baseUrl)!


                                if let thumbnailImage = self.createThumbnailOfVideoFromRemoteUrl(url: baseUrl)//(forUrl: url)
                                {
                                    DispatchQueue.main.async
                                        {
                                        cell.img.image = thumbnailImage
                                    }
                                
                             }
                        }


                    }

                }
                
                cell.platBtn.isHidden = false
            }
        }
        
        
        cell.editBtn.backgroundColor = UIColor.black
        cell.platBtn.tag = indexPath.row
        cell.platBtn.addTarget(self, action: #selector(PlayVideo), for: .touchUpInside)
        
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(DeletePost), for: .touchUpInside)
        return cell
    }

    @objc func PlayVideo(_ sender:UIButton)
    {
       var dict = self.mainArray.object(at: sender.tag) as! NSDictionary
        
        if let  imageData = dict.value(forKey: "fileName") as? String
        {
            if imageData != ""
            {
                var baseUrl = liveImageBaseURL + imageData
                let url = URL(string: baseUrl)!
                
                
               // let url = URL(string: data)!
                
                let player = AVPlayer(url: url)
                
                let vc = AVPlayerViewController()
                vc.player = player
                
                self.present(vc, animated: true)
                {
                    vc.player?.play()
                    
                }
                
            }
            
        }
       
    }
    @objc func DeletePost(_ sender:UIButton)
    {
        var dict = self.mainArray.object(at: sender.tag) as! NSDictionary
        
        if let  ID = dict.value(forKey: "ID") as? String
        {
            self.pinID = ID
        }
        
        let optionMenu = UIAlertController(title: "Alert!", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
               
                               self.DeletePostAPI()
            }
            
            
            
        })
        let deleteAction2 = UIAlertAction(title: "Cancel", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(deleteAction2)
        
        self.present(optionMenu, animated: true, completion: nil)
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
    
    func createThumbnailOfVideoFromRemoteUrl(url: String) -> UIImage? {
        let asset = AVAsset(url: URL(string: url)!)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 60)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    func AllPinBoardAPI()
    {
        var eventType = "celebaration"
        var eventID = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        
        
        let params:[String:Any] = [
            "email":userEmail
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:GETALLPINBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                DEFAULT.removeObject(forKey: "FromUpload")
                DEFAULT.synchronize()
                if self.mainArray.count>0
                {
                    self.mainArray.removeAllObjects()
                }
                if let dict = response as? NSDictionary
                {
                    
                    if let data = (dict.value(forKey: "data")) as? NSArray
                    {
                        
                        var mainArray2 = data
                        
                        
                        self.mainArray = (mainArray2.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                        
                    }
                   
                    
                }
                if self.mainArray.count>0
                {
                    self.nodataLbl.isHidden = true
                }
                else
                    
                {
                    self.nodataLbl.isHidden = false
                }
                DispatchQueue.main.async {
                    self.pinCollection.reloadData()
                    
                }
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
          
            
            
        }
        
    }
    
    func DeletePostAPI()
    {
       
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
    
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "eventImageVideos_ID":self.pinID
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETEPINBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                
            self.AllPinBoardAPI()
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
       
            
            
        }
        
    }
    
    
}



extension PinBoardViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let cellWidth : CGFloat = (UIScreen.main.bounds.width-13) / 2.0
        let cellheight = UIScreen.main.bounds.height  / 3.0
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2.0
    }
}
