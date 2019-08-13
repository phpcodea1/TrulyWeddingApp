//
//  SettingsViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SDWebImage

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    // @IBOutlet weak var tableView1: UITableView!
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
     var dataDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//       viewprofileAPI()
//        
//    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func passwordAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangeEmail_VC")  as! ChangeEmail_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func changePhoto(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePhoto_VC")  as! ChangePhoto_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func viewprofileAPI()
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
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:viewProfileURL, parameters: params) { (response, error) in
            if error == nil
            {
                self.viewProfileModel = Mapper<ViewProfileModel>().map(JSONObject: response)
                
                if self.viewProfileModel?.status == "success"
                {
                    
                    if let profileImg = self.viewProfileModel.data?.celebrationProfileImage
                    {
                        let img = URL(string: profileImg)
                        self.profileImage.layer.borderWidth = 1.0
                        self.profileImage.layer.masksToBounds = false
                        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
                        self.profileImage.layer.borderColor = UIColor.clear.cgColor
                        self.profileImage.clipsToBounds = true
                        
                    self.profileImage.sd_setImage(with:img, placeholderImage: UIImage(named: "image-1"))
                    }
                    
                    
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSDictionary
                        {
                        
                            if let id = dataDict.value(forKey: "id") as? String
                                
                            {
                                
                                DEFAULT.set(id, forKey: "eventID")
                                DEFAULT.synchronize()
                                
                            }
                            
                            if let event_type = dataDict.value(forKey: "event_type") as? String
                                
                            {
                                
                                DEFAULT.set(event_type, forKey: "eventType")
                                DEFAULT.synchronize()
                                
                            }
                            
                            
                            if let parnter = dataDict.value(forKey: "myself_image") as? String
                            {
                                let img = URL(string: parnter)
                                self.profileImage.layer.borderWidth = 1.0
                                self.profileImage.layer.masksToBounds = false
                                self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2
                                self.profileImage.layer.borderColor = UIColor.clear.cgColor
                                self.profileImage.clipsToBounds = true
                                
                                self.profileImage.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                                
                                
                            }
                         
                            
                        }
                        
                        var eventType = "celebaration"
                        var name = "Amar"
                        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
                        {
                            eventType = eventType1
                            
                            
                        }
                        
                        }
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                    
                    
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
        
    }
    
  
    
    
    

