//
//  NewVenueViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 19/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewVenueViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
   
    
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
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
       greenImagesArray = [UIImage(named:"image 3")!,UIImage(named: "image")!,UIImage(named: "image")!]
        
        self.tableView.tableHeaderView = topView
        tableView.register(UINib(nibName: "VenueHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "VenueHomeTableViewCell")
        
        let myColor : UIColor = UIColor.lightGray
        cityView.layer.borderColor = myColor.cgColor
        cityView.layer.borderColor = myColor.cgColor
        cityView.layer.borderWidth = 1.0
        cityView.layer.cornerRadius = 5
        
        if viewHide == "yes"
        {
            self.view1.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.hederLabel.textColor = UIColor.white
            self.reviewButton.isHidden = true
        }
        else{
            self.view1.backgroundColor = UIColor.white
            self.hederLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.reviewButton.isHidden = false
            
        }
        
        if backhide == "yes"
        {
            self.backButton.isHidden = false
        }
        else{
            self.backButton.isHidden = true
        }
      
    }
    @IBAction func reviewsAction(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return greenImagesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:
        "VenueHomeTableViewCell") as! VenueHomeTableViewCell
      
         cell.LongImg.image = greenImagesArray[indexPath.row]
        cell.requestBtn.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        cell.countLbl.layer.masksToBounds = true
        
        cell.countLbl.layer.cornerRadius = 5
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
        
        
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
    
    
    
}
