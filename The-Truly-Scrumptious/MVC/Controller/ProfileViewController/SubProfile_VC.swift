//
//  SubProfile_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 03/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import SVProgressHUD
import SDWebImage

class SubProfile_VC: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
     var dataDict = NSDictionary()
    
    @IBOutlet weak var aboutMeTxt: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        image1.isUserInteractionEnabled = true
       
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        self.emailLabel.text! = Email ?? ""

    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.profileImg1Click))
        Img1.delegate = self // This is not required
        image1.addGestureRecognizer(Img1)
    }
    
    // MARK -: ViewProfile API.
    
    func viewprofileAPI()
    {
        
        var eventType = "celebaration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
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
                self.image1.layer.borderWidth = 1.0
                self.image1.layer.masksToBounds = false
                self.image1.layer.cornerRadius = self.image1.frame.size.height/2
                self.image1.layer.borderColor = UIColor.clear.cgColor
                self.image1.clipsToBounds = true
                if self.viewProfileModel?.status == "success"
                {
                    
                    
                    if let profileImg = self.viewProfileModel.profileImage
                    {
                        let img = URL(string: profileImg)
                        
                        
                        self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "Splash-screen.png"))
                    }
                    else
                    
                    {
                        self.image1.image = UIImage(named: "Splash-screen.png")
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
                            
//
//                            if let parnter = dataDict.value(forKey: "myself_image") as? String
//                            {
//                                let img = URL(string: parnter)
//
//
//                                self.image1.layer.borderWidth = 1.0
//                                self.image1.layer.masksToBounds = false
//                                self.image1.layer.cornerRadius = self.image1.frame.size.height/2
//                                // + self.profileImg2.frame.height/2
//                                self.image1.layer.borderColor = UIColor.clear.cgColor
//                                self.image1.clipsToBounds = true
//
//
//                                self.image1.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
//
//                                //self.girlProfileBtn.sd_setImage(with:URL(string: "Your_url"), forState:.normal)
//
//                            }
//
//
                            if let about_me = dataDict.value(forKey: "about_me") as? String
                            {
                                self.aboutMeTxt.text = about_me
                            }
                            
                            if let name1 = DEFAULT.value(forKey: "name") as? String
                            {
                                self.emailLabel.text = name1
                                self.headerLabel.text = name1
                            }
                           
                            self.nameLabel.text! = Email ?? ""
                            
                        }
                        
                        
                        
                        var eventType = "celebaration"
                       // var name = "Amar"
                        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
                        {
                            eventType = eventType1
                            
                            
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
    
    
    @objc func profileImg1Click()
    {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePhoto_VC") as! ChangePhoto_VC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
