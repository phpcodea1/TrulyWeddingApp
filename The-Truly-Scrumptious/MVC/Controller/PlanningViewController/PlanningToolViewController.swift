//
//  PlanningToolViewController.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class PlanningToolViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var planButton: UIButton!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var cross:String = ""
    var eventType = "celebration"
    
    var total_budget = ""
                                                 
//    var array = ["Checklist","Budget","Venues","Add Guest","Event Guests","Suppliers","Wedding Show","Pin Board","My Favourit          es","My Events","Notice Board","Reviews","Table Plan","Menu Plan","List Plan"]
    
//    var array = ["Wedding Show","Check List","Venues","Add Guest","Event Guests","Suppliers","Wedding Show","Pin Board","My Favourites","My Events","Notice Board","Reviews","Table Plan","Menu Plan","List Plan"]
    
    var array = ["Budget","Tasks","Wedding Shows","Venues","Suppliers","Reviews","Pinboard","Noticeboard","My Favourites","Table Plan","Menu Plan","My Lists","Add Guest","All Guests","My Events","My Enquiries"]
    
 var imageArray = ["Budget-1","Check-list","Wedding-Show","Venue","Suppliers","star.1x","Pin-board","Notice-board","My-Favourites","Table-plan-1","Menu_plan","List_plan","guestList","guest_Events","My-events","message-notification"]
    
//    var imageArray = ["Check-list","Budget-1","Venue","guestList","guest_Events","Suppliers","Wedding-Show","Pin-board","My-Favourites","My-events","Notice-board","star.1x","Table-plan-1","Menu_plan","List_plan"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        myCollectionView.register(UINib(nibName: "PlanningCollectionViewCell", bundle: nil),        forCellWithReuseIdentifier: "PlanningCollectionViewCell")
        
                        
        if cross == "yes"
        {
            self.crossButton.isHidden = false
            
        }
        else{
            self.crossButton.isHidden = true
        }
    
        
       
       
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
            
        }
        if eventType.lowercased() == "wedding"
        {
           
            array = ["Budget","Tasks","Wedding Shows","Venues","Suppliers","Reviews","Pinboard","Noticeboard","My Favourites","Table Plan","Menu Plan","My Lists","Add Guest","All Guests","My Events","My Enquiries"]
            
            imageArray = ["Budget-1","Check-list","Wedding-Show","Venue","Suppliers","star.1x","Pin-board","Notice-board","My-Favourites","Table-plan-1","Menu_plan","List_plan","guestList","guest_Events","My-events","message-notification"]
        }
        else
        {
            array = ["Budget","Tasks","Venues","Suppliers","Reviews","Pinboard","Noticeboard","My Favourites","Table Plan","Menu Plan","My Lists","Add Guest","All Guests","My Events","My Enquiries"]
            
            imageArray = ["Budget-1","Check-list","Venue","Suppliers","star.1x","Pin-board","Notice-board","My-Favourites","Table-plan-1","Menu_plan","List_plan","guestList","guest_Events","My-events","message-notification"]
            
        }
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(true)
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            viewprofileAPI()
        }
        
        
        
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
            
        }
        if eventType.lowercased() == "wedding"
        {
           
            array = ["Budget","Tasks","Wedding Shows","Venues","Suppliers","Reviews","Pinboard","Noticeboard","My Favourites","Table Plan","Menu Plan","My Lists","Add Guest","All Guests","My Events","My Enquiries"]
            
            imageArray = ["Budget-1","Check-list","Wedding-Show","Venue","Suppliers","star.1x","Pin-board","Notice-board","My-Favourites","Table-plan-1","Menu_plan","List_plan","guestList","guest_Events","My-events","message-notification"]
            
        }
        else
        {
            array = ["Budget","Tasks","Venues","Suppliers","Reviews","Pinboard","Noticeboard","My Favourites","Table Plan","Menu Plan","My Lists","Add Guest","All Guests","My Events","My Enquiries"]
            
            imageArray = ["Budget-1","Check-list","Venue","Suppliers","star.1x","Pin-board","Notice-board","My-Favourites","Table-plan-1","Menu_plan","List_plan","guestList","guest_Events","My-events","message-notification"]
            
        }
        
        self.myCollectionView.reloadData()
    }
    
    @IBAction func planAction(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as! FindVenue_VC
       
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return array.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanningCollectionViewCell", for: indexPath) as? PlanningCollectionViewCell
        cell?.title.text = array[indexPath.row]
        cell?.img.image = UIImage(named: imageArray[indexPath.row])
       cell?.pulsButton.tag = indexPath.row
        
        cell?.pulsButton.addTarget(self, action: #selector(plusClick), for: .touchUpInside)
        
        if eventType.lowercased() == "wedding"
        {
            if indexPath.row == 14
            {
                cell?.pulsButton.isHidden = false
            }
            else{
                cell?.pulsButton.isHidden = true
            }
        }
        else
        {
            if indexPath.row == 13
            {
                cell?.pulsButton.isHidden = false
            }
            else{
                cell?.pulsButton.isHidden = true
            }
        }
       
        
        
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if eventType.lowercased() == "wedding"
        {
            if indexPath.row == 0
            {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "EditBudgetViewController") as! EditBudgetViewController
//                vc.fromBack = "yes"
//                self.navigationController?.pushViewController(vc, animated: true)
//
                print("fedwgefhnf")
                if self.total_budget == ""
                {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditBudgetViewController") as! EditBudgetViewController
                    vc.fromBack = "yes"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as! BudgetVC
                    vc.budgetAmount = self.total_budget
                    vc.fromPlanning = "yes"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
            else if indexPath.row == 1
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CheckListViewController") as! CheckListViewController
                vc.fromBack = "yes"
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 2
            {
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingShowViewController") as! WeddingShowViewController
                // vc.fromBack = "yes"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 3
            {
                //            let vc = storyboard?.instantiateViewController(withIdentifier: "MYNoticeBoardViewController") as! MYNoticeBoardViewController
                //            self.navigationController?.pushViewController(vc, animated: true)
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "VenuePricing_VC") as! VenuePricing_VC
                vc.backhide = "yes"
                vc.viewHide = "yes"
                vc.tittleChange = "header"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
            }
            else if indexPath.row == 4
            {
                
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingSuppliersViewController") as! WeddingSuppliersViewController
                vc.backHide = "yes"
                vc.viewHide1 = "yes"
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 5
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
                vc.backHidden = "yes"
                vc.viewHide2 = "yes"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 6
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PinBoardViewController") as! PinBoardViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            else if indexPath.row == 7
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MYNoticeBoardViewController") as! MYNoticeBoardViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 8
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyFavourite_VC") as! MyFavourite_VC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 9
            {
                
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllGuestViewController") as! AllGuestViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 10
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllMenuViewController") as! AllMenuViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 11
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllListViewController") as! AllListViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 12
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddGuestViewController") as! AddGuestViewController
                //vc.fromBack = "yes"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 13
            {
                //AllGuestListViewController
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllGuestListViewController") as! AllGuestListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 14
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyEvents_VC") as! MyEvents_VC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 15
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "VenueRequestViewController") as! VenueRequestViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
       
    }
        else
        {
            if indexPath.row == 0
            {
                print("fedwgefhnf")
                if self.total_budget == ""
                {
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditBudgetViewController") as! EditBudgetViewController
                    vc.fromBack = "yes"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else
                {
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as! BudgetVC
                    vc.budgetAmount = self.total_budget
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
            else if indexPath.row == 1
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "CheckListViewController") as! CheckListViewController
                vc.fromBack = "yes"
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
                //        else if indexPath.row == 2
                //        {
                //
                //            let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingShowViewController") as! WeddingShowViewController
                //            // vc.fromBack = "yes"
                //            self.navigationController?.pushViewController(vc, animated: true)
                //        }
            else if indexPath.row == 2
            {
                //            let vc = storyboard?.instantiateViewController(withIdentifier: "MYNoticeBoardViewController") as! MYNoticeBoardViewController
                //            self.navigationController?.pushViewController(vc, animated: true)
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "VenuePricing_VC") as! VenuePricing_VC
                vc.backhide = "yes"
                vc.viewHide = "yes"
                vc.tittleChange = "header"
                self.navigationController?.pushViewController(vc, animated: true)
                
                
                
            }
            else if indexPath.row == 3
            {
                
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingSuppliersViewController") as! WeddingSuppliersViewController
                vc.backHide = "yes"
                vc.viewHide1 = "yes"
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 4
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
                vc.backHidden = "yes"
                vc.viewHide2 = "yes"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 5
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PinBoardViewController") as! PinBoardViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
                
            }
            else if indexPath.row == 6
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MYNoticeBoardViewController") as! MYNoticeBoardViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 7
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyFavourite_VC") as! MyFavourite_VC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 8
            {
                
                
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllGuestViewController") as! AllGuestViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 9
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllMenuViewController") as! AllMenuViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            else if indexPath.row == 10
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllListViewController") as! AllListViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 11
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "AddGuestViewController") as! AddGuestViewController
                //vc.fromBack = "yes"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 12
            {
                //AllGuestListViewController
                let vc = storyboard?.instantiateViewController(withIdentifier: "AllGuestListViewController") as! AllGuestListViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 13
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "MyEvents_VC") as! MyEvents_VC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 14
            {
                let vc = storyboard?.instantiateViewController(withIdentifier: "VenueRequestViewController") as! VenueRequestViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    @IBAction func crossAction(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func plusClick()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SubHome_VC") as! SubHome_VC
        vc.backButton1 = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    func viewprofileAPI()
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
            "event_id":eventID,
            "event_type":eventType
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:viewProfileURL, parameters: params) { (response, error) in
            if error == nil
            {
               
                   
                    if let dict = response as? NSDictionary
                    {
                        if let dataDict = (dict.value(forKey: "data")) as? NSDictionary
                        {
                           
                            if let total_budget1 = dataDict.value(forKey: "total_budget") as? String
                            {
                                self.total_budget = total_budget1
                            }
                            
                            
                            else
                            {
                             
                            }
                        }
                        
                    }
                    
                }
                    
                    
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
        
    
    
    
    
}

extension PlanningToolViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        let cellWidth : CGFloat = UIScreen.main.bounds.width / 3.0
        let cellheight = UIScreen.main.bounds.height  / 3.0
        return CGSize(width: 120, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
}
