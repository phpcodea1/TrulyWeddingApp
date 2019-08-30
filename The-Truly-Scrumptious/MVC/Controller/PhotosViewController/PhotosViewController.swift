//
//  PhotosViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import ObjectMapper

class PhotosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    // outlet
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var hotelTitleLbl: UILabel!
    @IBOutlet weak var venueTypeLbl: UILabel!
    @IBOutlet weak var seatLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var LongImg: UIImageView!
    @IBOutlet weak var tellPhoneLbl: UILabel!
    
    
    @IBOutlet weak var ovrVenueType: UILabel!
    
    @IBOutlet weak var ovrEveningCap: UILabel!
    
    @IBOutlet weak var ovrBedCap: UILabel!
    
    @IBOutlet weak var ovrSleepLbl: UILabel!
    
    @IBOutlet weak var ovrAward: UILabel!
    
    @IBOutlet weak var ovrInsuLbl: UILabel!
    
    @IBOutlet weak var ovrQalifLbl: UILabel!
    @IBOutlet weak var ovtProfMem: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableview1: UITableView!
    
    var DetailModel:VenueDetailsModel!
    
    var nameArray = [String]()
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameArray = ["External Catering Permitted","Evening Reception Capacity","Civil Licence","Fireworks Permitted"]
        tableviewHeight.constant = CGFloat((nameArray.count * 40))
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            detailApi()
        }
        
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reviewsAction(_ sender: Any) {
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   
    
    @IBAction func sdf(_ sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
         vc.backHidden = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview1.dequeueReusableCell(withIdentifier: "PhotosTableViewCell") as! PhotosTableViewCell
        
        cell.nameLabel.text! = nameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
  
    func detailApi()
    {
      
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "id":self.id]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEDETAILS, parameters: params) { (response, error) in
            if error == nil
            {
              
                self.DetailModel = Mapper<VenueDetailsModel>().map(JSONObject: response)
                
              if self.DetailModel.status == "success"
              {
     
               if let address = self.DetailModel.data?.address
                {
                self.addressLbl.text = address
                 }
                if let address = self.DetailModel.data?.location
                {
                    self.addressLbl.text = address
                }
                
                if let address = self.DetailModel.data?.name
                {
                    self.headerLbl.text = address
                }
                if let address = self.DetailModel.data?.name
                {
                    self.hotelTitleLbl.text = address
                }
                if let address = self.DetailModel.data?.awards
                {
                    self.ovrAward.text = address
                }
                //
                if let amount = self.DetailModel.data?.bannerImage
                {
                    if amount != ""
                    {
                        let url1 = URL(string: amount)!
                        self.LongImg.sd_setImage(with: url1, completed: nil)
                    }
                    
                }
                
                if let address = self.DetailModel.data?.guest
                {
                    self.seatLbl.text = address
                }
                
                if let address = self.DetailModel.data?.telephoneNumber
                {
                    self.tellPhoneLbl.text = address
                }
                
                if let address = self.DetailModel.data?.qualification
                {
                    self.ovrQalifLbl.text = address
                }
               
                
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
}
