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
    
     var MainArray = NSMutableArray()
    var nameArray = [String]()
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view1.isHidden = true
        
        tableview1.register(UINib(nibName: "FavTableViewCell", bundle: nil), forCellReuseIdentifier: "FavTableViewCell")
        
       FavriteAPI()
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func suppliersAction(_ sender: UIButton) {
        
        self.view2.isHidden = true
        self.view1.isHidden = false
        
        
    }
    
    @IBAction func venueAction(_ sender: UIButton) {
        self.view2.isHidden = false
        self.view1.isHidden = true
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
        if let avgrating_persons = dict.value(forKey: "avgrating_persons") as? Int
        {
            
            cell.totalLbl.text = "\(avgrating_persons)" + " Reviews"
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
        
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
            var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
            
            if let id1 = dict.value(forKey: "id") as? String
            {
                vc.id = id1
            }
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
    
    func FavriteAPI()
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
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                       
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
