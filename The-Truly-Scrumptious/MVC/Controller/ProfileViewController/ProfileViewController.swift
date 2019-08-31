//
//  ProfileViewController.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD
import SDWebImage

class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet var tableView: UITableView!
    var titleArray = ["Planning Tools","Profile","Settings","Logout"] // ,"Help","Share the App"
    var imageArray = ["planner-32","user","setting","Log-out"] // ,"Help","Share-the-app"
    
    var viewProfileModel:ViewProfileModel!
    var profileData:ViewData?
    
    var logOutModelData:LogoutModel!
    var dataDict = NSDictionary()
    
    override func viewDidLoad()
    {
      
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        super.viewDidLoad()
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.ImageClick))
        Img1.delegate = self // This is not required
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(Img1)
        tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTableViewCell")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewprofileAPI()
        
    }
    
    @objc func ImageClick()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChangePhoto_VC") as! ChangePhoto_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return 80
        
        
    }
    @IBAction func crossAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell") as! ProfileTableViewCell
        cell.title.text = titleArray[indexPath.row]
        cell.img.image = UIImage(named: imageArray[indexPath.row])
        if indexPath.row == 0
        {
            cell.topView.isHidden = false
        }
        else
        {
            cell.topView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        ["Planning Tools","Profile","Settings","Logout"]
        if indexPath.row == 0
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlanningToolViewController") as! PlanningToolViewController
            
            vc.cross = "yes"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SubProfile_VC") as! SubProfile_VC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3
        {
            
            
            let alertController = UIAlertController(title: "Logout", message: "Do you want to  Logout?", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "Logout", style: .default)  {(action:UIAlertAction!) in
                
                if !(NetworkEngine.networkEngineObj.isInternetAvailable())
                {
                    NetworkEngine.networkEngineObj.showInterNetAlert()
                }
                else
                {
                     self.logOutAPI()
                }
                
               
                
                
                _ = UIApplication.shared.delegate as? AppDelegate
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                let nav = UINavigationController(rootViewController: vc)
                nav.setNavigationBarHidden(true, animated: true)
                defaultValues.setValue(nil, forKey: "tokenObj")
               // defaultValues.removeObject(forKey: "tokenObj")
//                DEFAULT.removeObject(forKey: "eventType")
//                DEFAULT.removeObject(forKey: "eventID")
                DEFAULT.synchronize()

                UserDefaults.standard.synchronize()
                if let window = UIApplication.shared.windows.first
                {
                    window.rootViewController = nav
                    window.makeKeyAndVisible()
                }
                
            }
            let OKAction1 = UIAlertAction(title: "Cancel", style: .default)  {(action:UIAlertAction!) in
            }
            alertController.addAction(OKAction1)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion:nil)
            
         
        }
        
    }
    
    // MARK -: Logout API.
    
    func logOutAPI()
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
            "event_type":eventType]
        
        print(params)
        
        WebService.shared.apiDataPostMethod(url:logoutURL, parameters: params) { (response, error) in
            if error == nil
            {
                SVProgressHUD.dismiss()
                self.logOutModelData = Mapper<LogoutModel>().map(JSONObject: response)
                
                if self.logOutModelData?.status == "success"
                {
                    
                   
                      DEFAULT.removeObject(forKey: "email")
                    DEFAULT.removeObject(forKey: "eventType")
                    DEFAULT.removeObject(forKey: "eventID")
                    DEFAULT.synchronize()
                    
                }
                else if self.logOutModelData?.status == "fail"
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:self.logOutModelData?.message ?? "")
                    
                }
                
            }
        }
        
    }
    
    
    // MARK -: ViewProfile API.
    
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
    
                        
                        if let name = self.viewProfileModel?.data?.personName
                        {
                            self.nameLabel.text! = name
                        }
                        self.profileImg.layer.borderWidth = 1.0
                        self.profileImg.layer.masksToBounds = false
                        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height/2
                        // + self.profileImg2.frame.height/2
                        self.profileImg.layer.borderColor = UIColor.clear.cgColor
                        self.profileImg.clipsToBounds = true
                        
                        if let profileImg = self.viewProfileModel.profileImage
                        {
                            if profileImg != ""
                            {
                                let img = URL(string: profileImg)
                                
                                self.profileImg.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                            }
                           
                        }
                        else{
                            self.profileImg.image =  UIImage(named: "image-1")
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
                                
                                
                                if let parnter = dataDict.value(forKey: "parnter") as? String
                                {
                                    self.nameLabel.text! = parnter
                                }
                                self.profileImg.layer.borderWidth = 1.0
                                self.profileImg.layer.masksToBounds = false
                                self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height/2
                                // + self.profileImg2.frame.height/2
                                self.profileImg.layer.borderColor = UIColor.clear.cgColor
                                self.profileImg.clipsToBounds = true
                                
                                if let parnter = dict.value(forKey: "profileImage") as? String
                                {
                                    if parnter != ""
                                    {
                                        let img = URL(string: parnter)
                                        
                                        self.profileImg.sd_setImage(with: img, placeholderImage: UIImage(named: "image-1"))
                                    }
                                   
                                    
                               
                                }
                                
                                
                                }
                           
                            
                                var eventType = "celebaration"
                                var name = "Amar"
                                if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
                                {
                                    eventType = eventType1
                                    
                                    
                                }
                                if let name1 = DEFAULT.value(forKey: "name") as? String
                                {
                                    name = name1
                                    self.nameLabel.text! = name1
                                    
                                }
//                                if eventType == "wedding"
//                                {
//                                    if let partner_name = self.dataDict.value(forKey: "partner_name") as? String
//                                    {
//
//                                        self.nameLabel.text! = partner_name
//                                    }
//                                }
                            
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
    
    

