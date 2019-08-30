//
//  NewCatSupplierViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 07/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewCatSupplierViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    
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
    
    
    var likeStatus = "0"
    var LikeId = ""
    
    var selectedFav = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.serachTXT.delegate = self
         self.serachTXT.addTarget(self, action: #selector(searchText), for: .editingChanged)
        
        let myColor : UIColor = UIColor.lightGray
        searchView.layer.borderColor = myColor.cgColor
        searchView.layer.borderColor = myColor.cgColor
        searchView.layer.borderWidth = 1.0
        searchView.layer.cornerRadius = 5
        selectedFav = -1
        self.CatDetailApi()
        
       
            self.notFoundLbl.isHidden = true
        
     
       
        tableview1.tableHeaderView = topView
        tableview1.register(UINib(nibName: "VenueHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueHomeTableViewCell")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.CatDetailApi()
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
                var name = dict.value(forKey: "location") as! String
                
                
                let range1 = name.range(of: searchType, options: .caseInsensitive, range: nil, locale: nil)
                print(range1)
                if range1 != nil
                {
                    self.FilterArray.add(dict)
                }
            }
        }
        print(FilterArray)
        self.tableview1.reloadData()
        
        
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
                    let url1 = URL(string: amount)!
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
        
        
            if let is_fav = dict.value(forKey: "like") as? String
            {
                
        
                    if is_fav == "0"
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
        
        
        self.selectedFav = sender.tag
        
        var dict = self.FilterArray.object(at: sender.tag) as!NSDictionary
        
        if let login_id = dict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        if let login_id = dict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        
        if let is_fav = dict.value(forKey: "like") as? String
        {
            
            self.likeStatus = is_fav
        }
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
             self.SupplierLikeUnlikeAPI()
        }
       
        
    }
    @objc func requestBtnClick(_ sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendRequestSupplierViewController") as! SendRequestSupplierViewController
        var dict = self.FilterArray.object(at: sender.tag) as!NSDictionary
        
        vc.CAT_ID = self.catId
        if let id1 = dict.value(forKey: "login_id") as? String
        {
            vc.vendorId = id1
        }
      //  vc.titleText = "Message Supplier"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "VenueHomeTableViewCell") as! VenueHomeTableViewCell
        cell.backgroundColor = UIColor.white
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewSuplierDetailsViewController") as! NewSuplierDetailsViewController
        var dict = self.FilterArray.object(at: indexPath.row) as!NSDictionary
        
        
        if let id1 = dict.value(forKey: "id") as? String
        {
            vc.id = id1
        }
        if let login_id = dict.value(forKey: "login_id") as? String
        {
            vc.login_id = login_id
        }
        vc.cat_ID = catId
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    
    @IBAction func goBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func CatDetailApi()
    {
        
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
            "cat_id":self.catId,
            "event_type":eventType,
            "event_id":eventID]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:SUPPLIECATDETAILS, parameters: params) { (response, error) in
            if error == nil
            {
                
            
            
                if  let status = (response as! NSDictionary).value(forKey: "status") as? String
                {
                    if status == "success"
                    {
                        if let data1 = ((response as! NSDictionary).value(forKey: "data") as? NSDictionary)
                        {
                            if let suppliers = data1.value(forKey: "suppliers") as? NSArray
                            {
                               self.FilterArray = suppliers.mutableCopy() as! NSMutableArray
                            }
                            
                            if let id = data1.value(forKey: "id") as? String
                            {
                               self.catId = id
                            }
                            
                        }
                    }
                   
                    if self.FilterArray.count>0
                    {
                        self.notFoundLbl.isHidden = true
                    }
                    else
                    {
                        self.notFoundLbl.isHidden = false
                    }
                     self.hederLabel.text = "\(self.FilterArray.count)" + " Suppliers"
                    self.tableview1.reloadData()
                    
                    
                }
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                }
                
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    func SupplierLikeUnlikeAPI()
    {
        
        
        var likeStatus2 = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        if self.likeStatus == "0"
        {
            likeStatus2 = "1"
        }
        else
        {
            likeStatus2 = "0"
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
            "supplier_id":self.LikeId,
            "status":likeStatus2,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:SUPPLIERLIKEUNLIKE, parameters: params) { (response, error) in
            if error == nil
            {
                
                print(response)
                if let message = (response as! NSDictionary).value(forKey: "message") as? String
                {
                    self.view.makeToast(message)
                }
                self.CatDetailApi()
                
                
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
}
