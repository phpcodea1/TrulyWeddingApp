//
//  MyEvents_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 28/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SVProgressHUD
import SDWebImage

class MyEvents_VC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var nodataLbl: UILabel!
    
   var nameArray = [String]()
    var imageArray = [String]()
      var arrayData = NSArray()
    
    var selectedEventId = ""
    var selectedEventType = ""
    
    var activeEventId = ""
    var activeEventType = ""
    
    var mainArray = NSMutableArray()
    
    @IBOutlet weak var myTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nodataLbl.isHidden = true
        nameArray = ["Wedding","Birthday","Engagement","Ceremony","DJ Party"]
      
        myTableview.register(UINib(nibName: "AllEventTableViewCell", bundle: nil), forCellReuseIdentifier: "AllEventTableViewCell")
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
           ALLEVENTLISTAPI()
        }
        
        
    }
    
    
    
    @IBAction func plusAction(_ sender: UIButton) {
    
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
        vc.backButton1 = "yes"
        self.navigationController?.pushViewController(vc, animated: true)


    }
    
    @IBAction func backAction(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllEventTableViewCell") as! AllEventTableViewCell
        
        cell.wedSecImg.layer.cornerRadius =  cell.wedSecImg.frame.height/2
        cell.wedFirstImg.layer.cornerRadius =  cell.wedFirstImg.frame.height/2
        cell.celeProfileImg.layer.cornerRadius =  cell.celeProfileImg.frame.height/2
       
        if let dict = self.mainArray.object(at: indexPath.row) as? NSDictionary
        {
            if let type = dict.value(forKey: "event_type") as? String
            {
              cell.eventTypeLbl.text = type
            }
            
            if let select = dict.value(forKey: "select") as? Int
            {
                
               // cell.eventTypeLbl.text = select
                if select == 1
                {
                    cell.selectButton.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
                    cell.deleteButton.isHidden = true
                }
                else
                {
                    cell.selectButton.backgroundColor = UIColor.groupTableViewBackground
                    cell.deleteButton.isHidden = false
                }
                
            }
            
            if let type = dict.value(forKey: "event_type") as? String
            {
                
                if type.lowercased() == "wedding"
                {
                    cell.weddingUIView.isHidden = false
                    cell.celeUiView.isHidden = true
                    cell.eventDateLbl.text = convertDateFormater(dict.value(forKey: "wedding_date") as! String)
                    if let myself_image = dict.value(forKey: "myself_image") as? String
                    {
                        if myself_image == ""
                        {
                            cell.wedFirstImg.image = UIImage(named: "image-1")
                        }
                        else
                        {
                        let img = URL(string: myself_image)
                        cell.wedFirstImg.sd_setImage(with: img, placeholderImage: nil)
                        }
                    }
                    else
                    {
                       cell.wedFirstImg.image = UIImage(named: "image-1")
                    }
                    if let parnter_image = dict.value(forKey: "parnter_image") as? String
                    {
                        if parnter_image == ""
                        {
                            cell.wedSecImg.image = UIImage(named: "image-1")
                        }
                        else
                        {
                            let img = URL(string: parnter_image)
                            cell.wedSecImg.sd_setImage(with: img, placeholderImage: nil)
                        }
                        
                       
                    }
                    else
                    {
                        cell.wedSecImg.image = UIImage(named: "image-1")
                    }
                }
                else
                {
                    
                    cell.weddingUIView.isHidden = true
                      cell.celeUiView.isHidden = false
                    
                    if let celebration_date = dict.value(forKey: "celebration_date") as? String
                    {
                        if celebration_date != ""
                        {
                          cell.eventDateLbl.text = convertDateFormater(celebration_date)
                        }
                       
                    }
                    
                    
                    if let celebration_profile_image = dict.value(forKey: "celebration_profile_image") as? String
                    {
                        if celebration_profile_image == ""
                        {
                            cell.celeProfileImg.image = UIImage(named: "image-1")
                        }
                        else
                        {
                            let img = URL(string: celebration_profile_image)
                            cell.celeProfileImg.sd_setImage(with: img, placeholderImage: nil)
                        }
                      
                    }
                    else
                    {
                        cell.celeProfileImg.image = UIImage(named: "image-1")
                    }
                }
            }
       
            
            
        }
        cell.selectButton.tag = indexPath.row
        
        cell.selectButton.addTarget(self, action: #selector(SelectButtonClick), for: .touchUpInside)
        
        cell.deleteButton.tag = indexPath.row
        
        cell.deleteButton.addTarget(self, action: #selector(deleteButtonClick), for: .touchUpInside)
        
        return cell
    }
    
    @objc func SelectButtonClick(_ sender:UIButton)
    {
        
        if let dict = self.mainArray.object(at: sender.tag) as? NSDictionary
        {
            if let type = dict.value(forKey: "event_type") as? String
            {
                DEFAULT.set(type, forKey: "eventType")
            }
            if let id = dict.value(forKey: "id") as? String
            {
                DEFAULT.set(id, forKey: "eventID")
            }
            
            DEFAULT.synchronize()

            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                 self.SelectEventAPI()
            }
            
        }
        
    }
    @objc func deleteButtonClick(_ sender:UIButton)
    {
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
                if let dict = self.mainArray.object(at: sender.tag) as? NSDictionary
                {
                    if let type = dict.value(forKey: "event_type") as? String
                    {
                        self.selectedEventType = type
                    }
                    if let id = dict.value(forKey: "id") as? String
                    {
                        self.selectedEventId = id
                    }
                }
               
               self.DeleteEventAPI()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }

   
  
    
    func ALLEVENTLISTAPI()
    {
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
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
        
        
        
        let params:[String:Any] = [
            "email":userEmail
        ]
        
        
        print(params)
        print("para in save = \(params)")
        Alamofire.request(ALLEVENTS, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseString
            {
                response in
                switch response .result {
                case .success:
                    
                    
                    var a = response.result.value as! String
                    var b = response.result.value as! String
                    var data = a.replacingOccurrences(of: " ", with: "")
                    var data2 = b.replacingOccurrences(of: "null", with: "")
                    
                    
                    if let data = data.data(using: String.Encoding.utf8)
                    {
                        print("data in \(data)")
                        do {
                            if let dict = try JSONSerialization.jsonObject(with: data, options:.mutableLeaves) as? [String: Any]
                            {
                                print("dic t converted \(dict)")
                                if(dict["message"] as! String == "successfully")
                                {
                                   // if eventType.lowercased() == "wedding"
                                   // {
                                    //var weddingArray = NSMutableArray()
                                    
                                    if let event_id = dict["event_id"] as? String
                                    {
                                        self.activeEventId = event_id
                                    }
                                    if let event_type = dict["event_type"] as? String
                                    {
                                        self.activeEventType = event_type
                                    }
                                    
                                        if let array = dict["wedding_data"] as? NSArray
                                        {
                                           self.mainArray = array.mutableCopy() as! NSMutableArray
                                        }
                                        
                                   // }
//                                    else
//                                    {
                                    var celeArray = NSMutableArray()
                                    
                                    
                                        if let array = dict["celebration_data"] as? NSArray
                                        {
                                            celeArray = array.mutableCopy() as! NSMutableArray
                                        }
                                        
                                    //}
                                    for dict in celeArray
                                    {
                                        self.mainArray.add(dict)
                                    }
                                  
                                  //  self.mainArray = (self.mainArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                                    
//                                  self.mainArray = (self.mainArray.sorted(by: {
//                                        (($0 as! Dictionary<String, AnyObject>)["created_at"] as? String)! > (($1 as! Dictionary<String, AnyObject>)["created_at"] as? String)!
//                                    }) as NSArray).mutableCopy() as! NSMutableArray
//
//
                                    
                                    print("mainArray count \(self.mainArray.count)")
                                    
                                }
                                for i in 0..<self.mainArray.count
                                {
                                if let dict2 = self.mainArray.object(at: i) as? NSDictionary
                                {
                                var activeEventId2 = dict2.value(forKey: "id") as? String
                                var activeEventType2 = dict2.value(forKey: "event_type") as? String
                                if self.activeEventType == activeEventType2 && self.activeEventId == activeEventId2
                                {

                                    var dict3 = dict2

                                  self.mainArray.removeObject(at: i)
                                    self.mainArray.insert(dict3, at: 0)
                                }

                                }
                                }
                                 self.myTableview.reloadData()
                                if self.mainArray.count>0
                                {
                                    self.nodataLbl.isHidden = true
                                }
                                else
                                    
                                {
                                    self.nodataLbl.isHidden = false
                                }
                                self.myTableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                            }
                            
                        
                           
                            
                            SVProgressHUD.dismiss()
                        }
                        catch
                        {
                            SVProgressHUD.dismiss()
                           
                        }
                    }
                    else
                    {
                        print("else resp \(response)")
                    }
                    
                    
                    
                    
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                  
                    print(error)
                    SVProgressHUD.dismiss()
                }
                // SVProgressHUD.dismiss()
        }
        
        // SVProgressHUD.dismiss()
    }
    
    func SelectEventAPI()
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
        WebService.shared.apiDataPostMethod(url:SELECTEVENTAPI, parameters: params) { (response, error) in
            if error == nil
            {
                
                    self.ALLEVENTLISTAPI()
                    
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSDictionary
                        {
                            
                            if let about_me = dataDict.value(forKey: "about_me") as? String
                            {
                                //self.aboutMeTxt.text = about_me
                            }
                            
                            if let name1 = DEFAULT.value(forKey: "name") as? String
                            {
                              
                            }
                            
                         
                            
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
        
    func DeleteEventAPI()
    {
        
        
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":self.selectedEventId,
            "event_type":self.selectedEventType
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETETEVENTAPI, parameters: params) { (response, error) in
            if error == nil
            {
                
                self.ALLEVENTLISTAPI()
       
            }
        
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM-dd-yyyy"
        let date2 = dateFormatter.date(from: date)
        
        
        dateFormatter.dateFormat = "dd MMMM yyyy"
        
        if date2 != nil
        {
            return  dateFormatter.string(from: date2!)
        }
        else
        {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date3 = dateFormatter.date(from: date)
            
            
            dateFormatter.dateFormat = "dd MMMM yyyy"
            
            if date3 != nil
            {
              return  dateFormatter.string(from: date3!)
            }
            else
            {
                return  ""
            }
            
        }
        
        
    }
}
extension Array {
    mutating func move(at oldIndex: Int, to newIndex: Int) {
        self.insert(self.remove(at: oldIndex), at: newIndex)
    }
}
