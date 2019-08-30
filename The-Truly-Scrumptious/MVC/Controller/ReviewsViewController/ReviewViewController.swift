//
//  ReviewViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FloatRatingViewDelegate,UITextViewDelegate {
   
   
    @IBOutlet weak var messageText: UILabel!
    
    @IBOutlet weak var longImg: UIImageView!
    
    @IBOutlet weak var smallImg: UIImageView!
    
    @IBOutlet weak var nameTxt: UILabel!
    
    @IBOutlet weak var avgRating: FloatRatingView!
    
    
    @IBOutlet weak var totalReviewLbl: UILabel!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var reviewCharCount: UILabel!
    
    
    @IBOutlet weak var yesSegmt: UISegmentedControl!
    @IBOutlet weak var reviewTextfiled: UITextField!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var titleTextfiled: UITextField!
    @IBOutlet weak var textview1: UITextView!
    
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableview1: UITableView!
    var nameArray = [String]()
    var viewHide2:String = ""
    @IBOutlet weak var headerLabel: UILabel!
    var backHidden:String = ""
    
    var fromVenue = ""
    
    
    var Quality_of_product_or_service = ""
    var Communication = ""
    var Professionalism = ""
    var Flexibilty = ""
    var Value_for_Money = ""
    
    
    var VenueId = ""
    var average_rating = 0.0
    var mainDict = NSDictionary()
    
    

    
    var commonCell:ReviewTableViewCell!
    
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameArray = ["1.Quality of product or service","2. Communication","3. Professionalism","4. Flexibilty","5. Value for Money"]
        tableViewHeight.constant = CGFloat((nameArray.count * 70))
        let myColor : UIColor = UIColor.darkGray
        titleTextfiled.layer.borderColor = myColor.cgColor
        titleTextfiled.layer.borderColor = myColor.cgColor
        titleTextfiled.layer.borderWidth = 1.0
        titleTextfiled.layer.cornerRadius = 5
        
        
        if fromVenue == "no"
        {
           messageText.text = "How would you rate this supplier?"
        }
        else
        {
             messageText.text = "How would you rate this venue?"
        }
        
       
        
        Quality_of_product_or_service = "1"
        Communication = "1"
        Professionalism = "1"
        Flexibilty = "1"
        Value_for_Money = "1"
        
        let myColor1 : UIColor = UIColor.darkGray
        textview1.layer.borderColor = myColor1.cgColor
        textview1.layer.borderColor = myColor1.cgColor
        textview1.layer.borderWidth = 1.0
        textview1.layer.cornerRadius = 5
        
     
        yesSegmt.layer.borderColor = myColor1.cgColor
        yesSegmt.layer.borderColor = myColor1.cgColor
        yesSegmt.layer.borderWidth = 1.0
       
        yesSegmt.layer.cornerRadius = yesSegmt.frame.height/2
        yesSegmt.clipsToBounds=true
        
        
        textview1.delegate = self
        
        if viewHide2 == "yes"
        {
            self.view3.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.headerLabel.textColor = UIColor.white
            self.reviewsButton.isHidden = true
        }
        else{
            self.view3.backgroundColor = UIColor.white
            self.headerLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.reviewsButton.isHidden = false
        }
        
        if backHidden == "yes"
        {
            self.backButton.isHidden = false
             self.headerLabel.textColor = UIColor.white
            self.view3.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.reviewsButton.isHidden = true
        }
        else{
            self.backButton.isHidden = true
            self.view3.backgroundColor = UIColor.white
            self.headerLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.reviewsButton.isHidden = false
        }
        
        
        if let address = self.mainDict.value(forKey: "address") as? String
        {
          addressLbl.text = "Address: "   + address
        }
        
//        if let type = self.mainDict.value(forKey: "type") as? String
//        {
//            if type.lowercased() == "v"
//            {
//                cell.venueTypeLbl.text = "Venue"
//            }
//            else
//            {
//                cell.venueTypeLbl.text = "Supplier"
//            }
//
//        }
        
        
        if let address = self.mainDict.value(forKey: "name") as? String
        {
            self.nameTxt.text = address
        }
//        if let address = self.mainDict.value(forKey: "name") as? String
//        {
//            t.text = address
//        }
        
        if let amount = self.mainDict.value(forKey: "banner_image") as? String
        {
            
            if amount != ""
            {
                let url1 = URL(string: amount)!
                longImg.sd_setImage(with: url1, completed: nil)
            }
           
        }
        if let id = self.mainDict.value(forKey: "login_id") as? String
        {
            
            self.VenueId = id
        }
        
      
       
        if let avgrating_persons = self.mainDict.value(forKey: "avgrating_persons") as? Int
        {
            if average_rating>1
            {
               totalReviewLbl.text =  "\(avgrating_persons)" + "Reviews"
            }
            else
            
            {
                totalReviewLbl.text =  "\(avgrating_persons)" + "Review"
            }
            
        }
        if let avgrating = self.mainDict.value(forKey: "avgrating") as? Int
        {
            avgRating.rating =  Float(avgrating)
        }
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        
        self.reviewCharCount.text = "Write your review " + "\(numberOfChars)" + " / 30"
        return numberOfChars < 30    // 10 Limit Value
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
       // self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func reviewsAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
        
    self.commonCell = cell
        
        cell.nameLabel.text! = nameArray[indexPath.row]
        cell.rating.tag = indexPath.row
        cell.rating.delegate = self
        
        
        
        return cell
        
    }
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float)
    {
        if ratingView.tag == 0
        {
            Quality_of_product_or_service = "\(Float(rating))"
            average_rating = average_rating + Double((Float(rating)))
        }
            
       else if ratingView.tag == 1
        {
            Communication = "\(Float(rating))"
            average_rating = average_rating + Double((Float(rating)))
        }
        else if ratingView.tag == 2
        {
            Professionalism = "\(Float(rating))"
            average_rating = average_rating + Double((Float(rating)))
        }
        else if ratingView.tag == 3
        {
            Flexibilty = "\(Float(rating))"
            average_rating = average_rating + Double((Float(rating)))
        }
        else
        {
            Value_for_Money = "\(Float(rating))"
            average_rating = average_rating + Double((Float(rating)))
        }
        
        
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    @IBAction func postAction(_ sender: UIButton)
    {
        
        print(self.commonCell.rating.rating)
        
        print("Rating here = ")
        print(Quality_of_product_or_service)
        print(Communication)
        print(Professionalism)
        print(Flexibilty)
        print(Value_for_Money)
        
        
        if  (titleTextfiled.text?.count == 0) || (textview1.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {

            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                self.AddRetingAPI()
            }
        }
        
        
    }
    
    
    func AddRetingAPI()
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
        var recom = "1"
        if yesSegmt.selectedSegmentIndex == 0
        {
            recom = "1"
        }
        else
        {
            recom = "0"
        }
        var username = "Ganesh"
        if let name1 = DEFAULT.value(forKey: "name") as? String
        {
            username = name1
           
            
        }
        var params:[String:Any] = [:]
    var api = ""
        
        if fromVenue == "yes"
        {
       
            params =
                [
                    "email":userEmail,
                    "event_id":eventID,
                    "venue_id":self.VenueId,
                    "customer_name":username,
                    "quality_rating":Quality_of_product_or_service,
                    "communication_rating":Communication,
                    "professionalism_rating":Professionalism,
                    "flexibility_rating":Flexibilty,
                    "average_rating":"\(Int(average_rating/5))",
                    "recommend_company":recom,
                    "event_type":eventType,
                    "review_text": textview1.text!,
                    "title":titleTextfiled.text!,
                    "value_money_rating":self.Value_for_Money
                    
            ]
        api = ADDVENUERATING
        }
        else
        
        {
            params =
                [
                    "email":userEmail,
                    "event_id":eventID,
                    "supplier_id":self.VenueId,
                    "customer_name":username,
                    "quality_rating":Quality_of_product_or_service,
                    "communication_rating":Communication,
                    "professionalism_rating":Professionalism,
                    "flexibility_rating":Flexibilty,
                    "average_rating":"\(Int(average_rating/5))",
                    "recommend_company":recom,
                    "event_type":eventType,
                    "review_text": textview1.text!,
                    "title":titleTextfiled.text!,
                    "value_money_rating":self.Value_for_Money
                    
            ]
            api = ADDSUPPLIERRATING
            
        }
        
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:api, parameters: params) { (response, error) in
            if error == nil
            {
                
                if let resp = response as? NSDictionary
                {
                    if let resp = resp.value(forKey: "status") as? String
                    {
                        if resp  == "success"
                        {
                            self.navigationController?.popViewController(animated: true)
                        }
                        
                        
                    }
                    else
                    {
                        if let msg = resp.value(forKey: "message") as? String
                        {
                            Helper.helper.showAlertMessage(vc: self, titleStr: "Message!", messageStr:msg)
                        }
                        
                    }
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
}
