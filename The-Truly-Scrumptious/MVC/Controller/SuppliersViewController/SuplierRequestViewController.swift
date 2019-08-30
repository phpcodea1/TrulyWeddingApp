//
//  SuplierRequestViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//
import UIKit
import SVProgressHUD

class SuplierRequestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    var MainArray = NSArray()
    
    @IBOutlet weak var nodataLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.register(UINib(nibName: "RequestVenueTableViewCell", bundle: nil), forCellReuseIdentifier: "RequestVenueTableViewCell")
        // Do any additional setup after loading the
        self.nodataLbl.isHidden = true
        //AllRequestAPI()
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  MainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView1.dequeueReusableCell(withIdentifier: "RequestVenueTableViewCell") as! RequestVenueTableViewCell
        
        var dict = self.MainArray.object(at: indexPath.row) as! NSDictionary
        
       
        
        if let message = dict.value(forKey: "message") as? String
        {
            cell.messagelbl.text = message
        }
        if let event_date = dict.value(forKey: "event_date") as? String
        {
            cell.dateLbl.text = self.convertDateFormater(event_date)
        }
        
        if let status = dict.value(forKey: "status") as? String
        {
            if status == "0"
            {
                cell.satuslabel.text = "Status: Pending"
            }
            else
            {
                cell.satuslabel.text = "Status: Attending"
            }
            
        }
        if let venue_detail = dict.value(forKey: "supplier_detail") as? NSDictionary
        {
            if let banner_image = venue_detail.value(forKey: "banner_image") as? String
            {
                if banner_image != ""
                {
                    let url1 = URL(string: banner_image)!
                    cell.imag.sd_setImage(with: url1, completed: nil)
                }
                
            }
            if let location = venue_detail.value(forKey: "location") as? String
            {
                
                cell.locaLbl.text = location
                
            }
            if let name = venue_detail.value(forKey: "name") as? String
            {
                
                cell.nameLbl.text = name
                
            }
        }
        cell.imag.layer.borderWidth = 0.2
        cell.imag.layer.masksToBounds = false
        cell.imag.layer.cornerRadius = cell.imag.frame.height/2.0
        cell.imag.clipsToBounds = true
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestVenueTableViewCell") as!
        RequestVenueTableViewCell
        
        cell.backgroundColor = UIColor.white
        tableView.deselectRow(at: indexPath, animated: true)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SupplierRequestDetailsViewController") as! SupplierRequestDetailsViewController
                var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
        

                    vc.mainDict = dict
                
                self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func AllRequestAPI()
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
        WebService.shared.apiDataPostMethod(url:GETVENUEREQUEST, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                SVProgressHUD.dismiss()
                
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
                self.tableView1.reloadData()
            }
                
                
            else
            {
                SVProgressHUD.dismiss()
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
