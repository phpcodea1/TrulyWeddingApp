//
//  ReviewViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FloatRatingViewDelegate {
   
   
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
    
    
    var Quality_of_product_or_service = ""
    var Communication = ""
    var Professionalism = ""
    var Flexibilty = ""
    var Value_for_Money = ""
    
    
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
        
        // Do any additional setup after loading the view.
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
        }
       else if ratingView.tag == 1
        {
            Communication = "\(Float(rating))"
        }
        else if ratingView.tag == 2
        {
            Professionalism = "\(Float(rating))"
        }
        else if ratingView.tag == 3
        {
            Flexibilty = "\(Float(rating))"
        }
        else
        {
            Value_for_Money = "\(Float(rating))"
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
        
    }
    
}
