//
//  MyFavourite_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD

class MyFavourite_VC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var nodataLbl: UILabel!
    var MainArray = NSMutableArray()
    var nameArray = [String]()
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view1.isHidden = false
        self.view2.isHidden = true
        tableview1.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "FavTableViewCell")
        self.nodataLbl.isHidden = true
       
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            FavriteSuplierAPI()
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view1.isHidden = false
        self.view2.isHidden = true
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            FavriteSuplierAPI()
        }
    }

    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func suppliersAction(_ sender: UIButton) {
        
        self.view2.isHidden = true
        self.view1.isHidden = false
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            FavriteSuplierAPI()
        }
        
        
    }
    
    @IBAction func venueAction(_ sender: UIButton)
    {
        self.view2.isHidden = false
        self.view1.isHidden = true
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            FavriteVenueAPI()
        }
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview1.dequeueReusableCell(withIdentifier: "FavTableViewCell") as!
        FavTableViewCell
        
        var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
        
        
        if let amount = dict.value(forKey: "banner_image") as? String
        {
            if amount != ""
            {
                let url1 = URL(string: amount)!
                cell.profileImg.sd_setImage(with: url1, completed: nil)
            }
           
        }
        if let avgrating = dict.value(forKey: "avgrating") as? Int
        {
            cell.ratingUIView.rating = Float(avgrating)
        }
        else
        {
            cell.ratingUIView.rating = Float(0)
        }
        if let avgrating_persons = dict.value(forKey: "avgrating_persons") as? Int
        {
            if avgrating_persons > 1
            {
                cell.totalLbl.text =  "\(avgrating_persons)" + " Reviews"
            }
            else
            {
                cell.totalLbl.text =  "\(avgrating_persons)" + " Review"
            }
            
           
        }
        else
        {
             cell.totalLbl.text =  "\(0)" + " Review"
        }
        
        if let name = dict.value(forKey: "name") as? String
        {
            cell.nameLbl.text = name
        }
        
        if let location = dict.value(forKey: "location") as? String
        {
            cell.locationlbl.text = location
        }

     
        cell.profileImg.layer.borderWidth = 0.2
        cell.profileImg.layer.masksToBounds = false
        cell.profileImg.layer.cornerRadius = cell.profileImg.frame.height/2.0
        cell.profileImg.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        {
            let cell = tableview1.dequeueReusableCell(withIdentifier: "FavTableViewCell") as!
            FavTableViewCell
            
            cell.backgroundColor = UIColor.white
            tableView.deselectRow(at: indexPath, animated: true)
            
            if self.view1.isHidden
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
                
                var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
                
                if let id1 = dict.value(forKey: "id") as? String
                {
                    vc.id = id1
                }
                if let login_id = dict.value(forKey: "login_id") as? String
                {
                    vc.login_id = login_id
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else
            {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewSuplierDetailsViewController") as! NewSuplierDetailsViewController
                var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
                
                if let id1 = dict.value(forKey: "id") as? String
                {
                    vc.id = id1
                }
                if let cat_id = dict.value(forKey: "cat_id") as? String
                {
                    vc.cat_ID = cat_id
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
           
            
            
            
        }
    
    
    func FavriteVenueAPI()
    {
        SVProgressHUD.show()
       
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        var eventType = "wedding"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventType1
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType]
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEFAVRITE, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                SVProgressHUD.dismiss()
                if self.MainArray.count>0
                {
                    self.MainArray.removeAllObjects()
                }
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                       
                    }
                    if self.MainArray.count>0
                    {
                        self.nodataLbl.isHidden = true
                    }
                    else
                        
                    {
                        self.nodataLbl.isHidden = false
                    }
                }
                self.tableview1.reloadData()
            }
                
                
            else
            {
                SVProgressHUD.dismiss()
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    func FavriteSuplierAPI()
    {
        SVProgressHUD.show()
        
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        var eventType = "wedding"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventType1
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType]
        print(params)
        WebService.shared.apiDataPostMethod(url:SUPLIERFAVRITE, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                SVProgressHUD.dismiss()
                if self.MainArray.count>0
                {
                    self.MainArray.removeAllObjects()
                }
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                        
                    }
                    if self.MainArray.count>0
                    {
                        self.nodataLbl.isHidden = true
                    }
                    else
                        
                    {
                        self.nodataLbl.isHidden = false
                    }
                }
                self.tableview1.reloadData()
            }
                
                
            else
            {
                SVProgressHUD.dismiss()
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }


}
