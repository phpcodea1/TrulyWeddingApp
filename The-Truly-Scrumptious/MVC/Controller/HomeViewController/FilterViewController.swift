//
//  FilterViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 25/07/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

    import UIKit
    
    class FilterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate  {
        
        
        @IBOutlet weak var venueCountLbl: UILabel!
        @IBOutlet weak var serachTXT: UITextField!
        
        var greenImagesArray = [UIImage]()
        @IBOutlet weak var tittleLabel: UILabel!
        
        @IBOutlet weak var backButton: UIButton!
        var tittleChange:String = ""
        
        @IBOutlet weak var reviewButton: UIButton!
        @IBOutlet weak var hederLabel: UILabel!
        var backhide:String = ""
        var viewHide:String = ""
        @IBOutlet weak var view1: UIView!
        
        
        
        @IBOutlet weak var titleView: UIView!
        
        @IBOutlet weak var tableView: UITableView!
        
        @IBOutlet weak var cityView: UIView!
        
        @IBOutlet weak var topView: UIView!
        
        
        var searchlat = ""
        var searchLong = ""
        
        var catId = ""
        var civilCeremony = ""
        var noOfSeat = ""
        
        
        
        //var MainArray = NSArray()
        
        var MainArray = NSMutableArray()
        var FilterArray = NSMutableArray()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.FilterArray = self.MainArray.mutableCopy() as! NSMutableArray
            
            
            tableView.delegate = self
            tableView.dataSource = self
              self.serachTXT.delegate = self
            self.serachTXT.addTarget(self, action: #selector(searchText), for: .editingChanged)
            greenImagesArray = [UIImage(named:"image 3")!,UIImage(named: "image")!,UIImage(named: "image")!]
            
            self.tableView.tableHeaderView = topView
            tableView.register(UINib(nibName: "VenueHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueHomeTableViewCell")
            
            let myColor : UIColor = UIColor.lightGray
            cityView.layer.borderColor = myColor.cgColor
            cityView.layer.borderColor = myColor.cgColor
            cityView.layer.borderWidth = 1.0
            cityView.layer.cornerRadius = 5
            self.venueCountLbl.text = "\(MainArray.count)"  +  " Venues"
            
//            if viewHide == "yes"
//            {
//                self.view1.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
//                self.hederLabel.textColor = UIColor.white
//                self.reviewButton.isHidden = true
//            }
//            else{
//                self.view1.backgroundColor = UIColor.white
//                self.hederLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
//                self.reviewButton.isHidden = false
//
//            }
            
//            if backhide == "yes"
//            {
//                self.backButton.isHidden = false
//            }
//            else{
//                self.backButton.isHidden = true
//            }
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
            
            self.VenueFilter()
            
        }
        
        @objc func searchText(textField:UITextField)
        {
            print(textField.text!)
            print(self.MainArray.count)
            
            var searchType = textField.text!
            
            if textField.text! == nil
            {
                if self.FilterArray.count>0
                {
                    self.FilterArray.removeAllObjects()
                }
            }
            else
            {
                if self.FilterArray.count>0
                {
                    self.FilterArray.removeAllObjects()
                }
                for i in 0..<self.MainArray.count
                {
                    var dict = (self.MainArray.object(at: i) as! NSDictionary)
                    var name = dict.value(forKey: "name") as! String
                    
                    
                    let range1 = name.range(of: searchType, options: .caseInsensitive, range: nil, locale: nil)
                    print(range1)
                    if range1 != nil
                    {
                        self.FilterArray.add(dict)
                    }
                }
            }
            print(FilterArray)
            self.tableView.reloadData()
            
            
        }
        
        func textFieldDidEndEditing(_ textField: UITextField)
        {
            if textField.text! == ""
            {
                self.FilterArray = self.MainArray
            }
            self.tableView.reloadData()
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
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "VenueHomeTableViewCell") as! VenueHomeTableViewCell
            
            var dict = self.FilterArray.object(at: indexPath.row) as!NSDictionary
            
            
            
            if let amount = dict.value(forKey: "banner_image") as? String
            {
               
                let url1 = URL(string: amount)!
                cell.LongImg.sd_setImage(with: url1, completed: nil)
            }
            
            if let amount = dict.value(forKey: "price") as? String
            {
                 cell.amountLbl.text = amount
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
            
            if let name = dict.value(forKey: "name") as? String
            {
                cell.userNameLbl.text = name
            }
            else
            {
                cell.LongImg.image =    UIImage(named: "image")
            }
            
       
            
//            cell.LongImg.image = greenImagesArray[indexPath.row]
//            cell.requestBtn.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
//            cell.countLbl.layer.masksToBounds = true
//
//            cell.countLbl.layer.cornerRadius = 5
            
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
            
            var dict = self.FilterArray.object(at: indexPath.row) as! NSDictionary
            
            if let id1 = dict.value(forKey: "id") as? String
            {
                vc.id = id1
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
        
        //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        //    {
        //       return UITableView.automaticDimension
        //    }
        
        func VenueByNameAPI()
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
                "seat_capacity":serachTXT.text!,
                "civil_ceremony":"yes",
                "lat":"30.0",
                "long":"70.0"]
            
            
            print(params)
            WebService.shared.apiDataPostMethod(url:VENUEFILTER, parameters: params) { (response, error) in
                if error == nil
                {
                    
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSDictionary
                        {
                            
                            
                            
                            
                        }
                        
                    }
                    
                }
                    
                    
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
        
        func VenueFilter()
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
                "seat_capacity":self.noOfSeat,
                "civil_ceremony":self.civilCeremony,
                "lat":self.searchlat,
                "long":self.searchLong,
                "cat_id":self.catId]
            
            
            print(params)
            WebService.shared.apiDataPostMethod(url:VENUEFILTER, parameters: params) { (response, error) in
                if error == nil
                {
                
                    
                    
                    
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSArray
                        {
                           self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                              self.venueCountLbl.text = "\(self.MainArray.count)"  +  " Venues"
                           self.FilterArray = dataDict.mutableCopy() as! NSMutableArray
                        }
                        
                    }
                    self.tableView.reloadData()
                }
                    
                    
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
        
}

