//
//  VenuePricing_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD
import FloatRatingView
import SDWebImage
import Toast_Swift

class VenuePricing_VC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
   
    @IBOutlet weak var notFoundLbl: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var serachTXT: UITextField!
    @IBOutlet weak var tableview1: UITableView!
    var greenImagesArray = [UIImage]()
    @IBOutlet weak var tittleLabel: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    var tittleChange:String = ""
    
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var hederLabel: UILabel!
    var backhide:String = ""
    var viewHide:String = ""
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tableviewHegiht: NSLayoutConstraint!
    var MainArray = NSMutableArray()
    var FilterArray = NSMutableArray()
    
    @IBOutlet weak var topView: UIView!
    
    var searchlat = ""
    var searchLong = ""
    
    var catId = ""
    var civilCeremony = ""
    var noOfSeat = ""
    
    
    var likeStatus = 0
    var LikeId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview1.tableHeaderView = topView
        tableview1.register(UINib(nibName: "VenueHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueHomeTableViewCell")
        self.notFoundLbl.isHidden = true
//
//        DEFAULT.removeObject(forKey: "noOfSeat")
//        DEFAULT.removeObject(forKey: "civilCeremony")
//        DEFAULT.removeObject(forKey: "selectedCountryId")
//        DEFAULT.removeObject(forKey: "typeLong")
//        DEFAULT.removeObject(forKey: "typeLat")
//        DEFAULT.synchronize()
      
        
//        if viewHide == "yes"
//        {
//            self.view1.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
//            self.hederLabel.textColor = UIColor.white
//            self.reviewButton.isHidden = true
//        }
//        else{
////            self.view1.backgroundColor = UIColor.white
////            self.hederLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
////            self.reviewButton.isHidden = false
//
//        }
    
        if backhide == "yes"
        {
            self.backButton.isHidden = false
        }
        else{
            self.backButton.isHidden = true
        }
      //self.tableview1.estimatedRowHeight = 0
        //tableview1.rowHeight = 440
        
//        if tittleChange == "header"
//        {
//            self.tittleLabel.text = "Venue"
//        }
//        else{
//            self.tittleLabel.text = "Suppliers"
//        }
//        
        let myColor : UIColor = UIColor.lightGray
        searchView.layer.borderColor = myColor.cgColor
        searchView.layer.borderColor = myColor.cgColor
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 5
    //tableview1.frame.size.height = tableview1.contentSize.height
         greenImagesArray = [UIImage(named:"image 3")!,UIImage(named: "image")!,UIImage(named: "image")!]
     self.serachTXT.delegate = self
        
        self.serachTXT.addTarget(self, action: #selector(searchText), for: .editingChanged)
//        if let FromDeatail = DEFAULT.value(forKey: "FromDeatail") as? String
//        {
//            DEFAULT.removeObject(forKey: "FromDeatail")
//            DEFAULT.synchronize()
//        }
//        else
//        {
//            VenueFilter()
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        if let typeLat = DEFAULT.value(forKey: "typeLat") as? String
        {
            self.searchlat = typeLat
        }
        if let typeLong = DEFAULT.value(forKey: "typeLong") as? String
        {
            self.searchLong = typeLong
        }
        
        if let selectedCountryId = DEFAULT.value(forKey: "selectedCountryId") as? String
        {
            self.catId = selectedCountryId
        }
        if let civilCeremony = DEFAULT.value(forKey: "civilCeremony") as? String
        {
            self.civilCeremony = civilCeremony
        }
        
        if let noOfSeat = DEFAULT.value(forKey: "noOfSeat") as? String
        {
            self.noOfSeat = noOfSeat
        }
        
        if let FromDeatail = DEFAULT.value(forKey: "FromDeatail") as? String
        {
           DEFAULT.removeObject(forKey: "FromDeatail")
            DEFAULT.synchronize()
        }
        else
        {
            VenueFilter()
        }
      
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
       
       
    }
    
    
    @objc func searchText(textField1:UITextField)
    {
  
        if textField1.text! == nil
        {
            if self.FilterArray.count>0
            {
                self.FilterArray.removeAllObjects()
            }
        }
        else
        {
            if self.FilterArray.count>=1
            {
                self.FilterArray.removeAllObjects()
            }
            for i in 0..<self.MainArray.count
            {
                var dict = (self.MainArray.object(at: i) as! NSDictionary)
                var name = dict.value(forKey: "location") as! String
                
                if ((name.range(of: textField1.text!, options: .caseInsensitive, range: nil, locale: nil)) != nil)
                {
                    self.FilterArray.add(dict)
                }
               
            }
        }
           print(FilterArray)
         self.hederLabel.text = "\(self.FilterArray.count)"  +  " Venues"
        self.tableview1.reloadData()
        
        
    }
  
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if textField.text! == ""
        {
            if self.MainArray.count>0
            {
                self.FilterArray = self.MainArray
            }
            else
            {
                self.VenueFilter()
            }
        }
         self.hederLabel.text = "\(self.FilterArray.count)"  +  " Venues"
        self.tableview1.reloadData()
    }
    @IBAction func reviewsAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        

       
        
        return FilterArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "VenueHomeTableViewCell") as! VenueHomeTableViewCell
      
        
        var dict = self.FilterArray.object(at: indexPath.row) as!NSDictionary
        
        
        
   
        if let amount = dict.value(forKey: "banner_image") as? String
        {
            if amount != ""
            {
                let finalUrl = liveImageBaseURL + amount
                
                let url1 = URL(string: finalUrl)!
                
                cell.LongImg.sd_setImage(with: url1, completed: nil)
            }
            else
            {
                cell.LongImg.image = UIImage(named: "image")
            }
            
        }
        else
        {
            cell.LongImg.image = UIImage(named: "image")
        }
        if let amount = dict.value(forKey: "price") as? String
        {
            cell.amountLbl.text = amount
        }
        
        if let avgrating = dict.value(forKey: "avgrating") as? Int
        {
            cell.ratingUiView.rating = Float(avgrating)
        }
        
        if let avgrating_persons = dict.value(forKey: "avgrating_persons") as? Int
        {
            
          
            
            if avgrating_persons > 1
            {
                cell.reviewLbl.text =  "\(avgrating_persons)" + " Reviews"
            }
            else
            {
                cell.reviewLbl.text =  "\(avgrating_persons)" + " Review"
            }
        }
        
        if let description = dict.value(forKey: "description") as? String
        {
            cell.descLbl.text = description
        }
        
        if let amount = dict.value(forKey: "price") as? String
        {
            cell.amountLbl.text = amount
        }
        if let name = dict.value(forKey: "name") as? String
        {
            cell.userNameLbl.text = name
        }
        if let is_fav = dict.value(forKey: "is_fav") as? Int
        {
            if is_fav == 0
            {
               cell.likeBtn.setImage(UIImage(named: "unFav"), for: .normal)
            }
            else
            {
                cell.likeBtn.setImage(UIImage(named: "like"), for: .normal)
            }
        
        }
        
        
        
       
        
        if let name = dict.value(forKey: "name") as? String
        {
            cell.userNameLbl.text = name
        }
        else
        {
            cell.LongImg.image =    UIImage(named: "image")
        }
        
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
        
        cell.requestBtn.tag = indexPath.row
        cell.requestBtn.addTarget(self, action: #selector(requestBtnClick), for: .touchUpInside)
        
        return cell
    }
    
    @objc func likeBtnClick(_ sender: UIButton)
    {
        
        
        
        var dict = self.FilterArray.object(at: sender.tag) as!NSDictionary
        
        if let login_id = dict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        if let login_id = dict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        
        if let is_fav = dict.value(forKey: "is_fav") as? Int
        {
            
            self.likeStatus = is_fav
        }
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
             self.VenueLikeUnlikeAPI()
        }
      
       
    }
    @objc func requestBtnClick(_ sender: UIButton)
    {
      
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendRequestViewController") as! SendRequestViewController
        var dict = self.FilterArray.object(at: sender.tag) as!NSDictionary

        if let id1 = dict.value(forKey: "login_id") as? String
        {
            vc.vendorId = id1
        }
        vc.titleText = "Message Venue"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "VenueHomeTableViewCell") as! VenueHomeTableViewCell
        cell.backgroundColor = UIColor.white
        tableView.deselectRow(at: indexPath, animated: true)
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
        var dict = self.FilterArray.object(at: indexPath.row) as!NSDictionary
        
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
   
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func checkMarkButtonClicked ( sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageVendor_VC") as! MessageVendor_VC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func VenueByNameAPI()
    {
       
        var eventType = "celebaration"
        var eventID = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
     
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "venue_name":""]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEBYNAME, parameters: params) { (response, error) in
            if error == nil
            {
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                        self.FilterArray = dataDict.mutableCopy() as! NSMutableArray
                        
                        self.hederLabel.text = "\(self.MainArray.count)" + " Venues"
                         self.tableview1.reloadData()
                     
                    }
                    
                }
               
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    @IBAction func cleaeFilter(_ sender: UIButton)
    {
        
    }
    func VenueFilter()
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
            "seat_capacity":self.noOfSeat,
            "civil_ceremony":self.civilCeremony,
            "lat":self.searchlat,
            "long":self.searchLong,
            "cat_id":self.catId,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEFILTER, parameters: params) { (response, error) in
            if error == nil
            {
                self.searchlat = ""
                self.searchLong = ""
                self.noOfSeat = ""
                self.civilCeremony = ""
                self.catId = ""
                
                DEFAULT.removeObject(forKey: "noOfSeat")
                DEFAULT.removeObject(forKey: "civilCeremony")
                DEFAULT.removeObject(forKey: "selectedCountryId")
                DEFAULT.removeObject(forKey: "typeLong")
                DEFAULT.removeObject(forKey: "typeLat")
                DEFAULT.removeObject(forKey: "FromDeatail")
                DEFAULT.synchronize()
               
                SVProgressHUD.dismiss()
                
                if self.MainArray.count>0
                {
                    self.MainArray.removeAllObjects()
                    
                }
                if self.FilterArray.count>0
                {
                    self.FilterArray.removeAllObjects()
                    
                }
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                        self.hederLabel.text = "\(self.MainArray.count)"  +  " Venues"
                        self.FilterArray = dataDict.mutableCopy() as! NSMutableArray
                        if self.MainArray.count == 0
                        {
                            self.notFoundLbl.isHidden = false
                        }
                        else
                        
                        {
                             self.notFoundLbl.isHidden = true
                        }
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

    
    func VenueLikeUnlikeAPI()
    {
        
       
        var likeStatus2 = 1
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        if self.likeStatus == 0
        {
            likeStatus2 = 1
        }
        else
        {
             likeStatus2 = 0
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
            "venue_id":self.LikeId,
            "status":likeStatus2,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUELIKEUNLIKE, parameters: params) { (response, error) in
            if error == nil
            {
                if let message = (response as! NSDictionary).value(forKey: "message") as? String
                {
                   self.view.makeToast(message)
                }
            
                
                
                self.VenueFilter()
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
}
