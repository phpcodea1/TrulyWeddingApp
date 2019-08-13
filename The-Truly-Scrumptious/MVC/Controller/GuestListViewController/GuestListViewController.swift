//
//  GuestListViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 24/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class GuestListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate
{
    @IBOutlet weak var Uiview1: UIView!
    @IBOutlet weak var buttomDialog: UIView!
    
    @IBOutlet weak var Uiview3: UIView!
    @IBOutlet weak var Uiview2: UIView!
    @IBOutlet var backBtn: UIButton!
    @IBOutlet weak var GuestListTable: UITableView!
    var selectedSection2 = Int()
    var selectedSection3 = Int()
    var selectedSection = Int()
      var selectedRow = Int()
     var GuestListArray = NSMutableArray()
    var subArray = NSMutableArray()
    
    var guestId = ""
    
    var fromBack = ""
    
    var eventType = ""
    
    @IBOutlet var Headertitle: UILabel!
    var titleArray = ["Couple","My Family","My Friends","Mutual Friends","Partner's Friends","Partner's Family"]
    var titleArray1 = ["2 Guest","Nilson","Watson","Smith","Lara","Taylor"]
   
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        GuestListTable.delegate = self
        GuestListTable.dataSource = self
        self.GuestListTable.sectionHeaderHeight = UITableView.automaticDimension
        self.GuestListTable.estimatedSectionHeaderHeight = 100
        GuestListTable.rowHeight = UITableView.automaticDimension
        self.GuestListTable.rowHeight = 100
        eventType = "weeding"
        
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.View1Click))
        Img1.delegate = self // This is not required
        Uiview1.addGestureRecognizer(Img1)
        
        
        let Img2 = UITapGestureRecognizer(target: self, action: #selector(self.View2Click))
        Img2.delegate = self // This is not required
        Uiview2.addGestureRecognizer(Img2)
        
        
        let Img3 = UITapGestureRecognizer(target: self, action: #selector(self.View3Click))
        Img3.delegate = self // This is not required
        Uiview3.addGestureRecognizer(Img3)
        
        self.buttomDialog.isHidden = true
       
        //     selectedSection = -1
        
        //
        //        if fromBack == "yes"
        //        {
        //            self.backBtn.isHidden = false
        //            //  self.backBtn.isEnabled = false
        //        }
        //        else
        //        {
        //            self.backBtn.isHidden = true
        //            //self.backBtn.isEnabled = false
        //        }
        //
        
    }
    @objc func View1Click(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditGuestViewController") as! EditGuestViewController
        
        // let dict =  GuestListArray.object(at: indexPath.section) as! NSDictionary
        var dict = self.GuestListArray.object(at: self.selectedSection) as! NSDictionary
        
        if let memeberArray = dict.value(forKey: "member") as? NSArray
        {
            var dict1 = memeberArray.object(at: self.selectedRow) as! NSDictionary
          
            
            vc.GuestDetails = dict1
        }
        
        
        
        
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func View2Click(_ sender: UIButton)
    {
        var dict = self.GuestListArray.object(at: self.selectedSection) as! NSDictionary
        
        if let memeberArray = dict.value(forKey: "member") as? NSArray
        {
            var dict1 = memeberArray.object(at: self.selectedRow) as! NSDictionary
            self.guestId = dict1.value(forKey: "id") as! String
           
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
                        self.DeleteGuestAPI()
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
        
    }
    
    @objc func View3Click(_ sender: UIButton)
    {
    
        selectedSection = -1
        self.GuestListTable.reloadData()
      buttomDialog.isHidden = true
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
       self.buttomDialog.isHidden = true
        self.selectedRow =  -1
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            GetGestListAPI()
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return GuestListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        print("selcted section \(selectedSection)")
        var dict = self.GuestListArray.object(at: section) as! NSDictionary
        
        if let memeberArray = dict.value(forKey: "member") as? NSArray
        {
//            var dict1 = memeberArray.object(at: indexPath.row) as! NSDictionary
//            var name1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
//            cell.PartnerLabel.text = name1
            
            self.subArray = memeberArray.mutableCopy() as! NSMutableArray
        }
        if selectedSection != -1
        {
            if selectedSection == section
            {
                return  self.subArray.count //+ 1
            }
                
            else
            {
                return 0
            }
        }
        else
        {
            return 0
        }
        
        
        
//        var eventType = "wedding"
//        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
//        {
//            eventType = eventType1
//        }
//        if eventType == "wedding"
//        {
//            if  section == 0
//            {
//                return  2
//            }
//
//            else
//            {
//                return 0
//            }
//        }
//        else
//        {
//            return 0
//        }
//
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> CGFloat?
    {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("CellGuestListTableViewCell", owner: self, options: nil)?.first as! CellGuestListTableViewCell
        
        var dict = self.GuestListArray.object(at: indexPath.section) as! NSDictionary
        
        if let memeberArray = dict.value(forKey: "member") as? NSArray
        {
            var dict1 = memeberArray.object(at: indexPath.row) as! NSDictionary
           // print("member dict1 \(dict1)")
            var eventType = "wedding"
            if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
            {
                eventType = eventType1
            }
//            if eventType == "wedding"
//            {
              if let  name1 = dict1.value(forKey: "FIRSTNAME") as? String
                {
                    var name2 = name1 + " " + "(" + "attend" + ")"
                    cell.PartnerLabel.text = name2
                    
                    cell.checkBoxButton.isHidden = true
                    cell.checkBoxButton.isEnabled = false
                     cell.checkBoxButton.setImage(UIImage(named: "Checkbox"), for: .normal)
                }
                else
                {
                    var str1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
                    cell.checkBoxButton.isHidden = false
                     if let  attendence = dict1.value(forKey: "attendence") as? String
                     {
                        if attendence == ""
                        {
                              var name1 = str1 
                            cell.PartnerLabel.text = name1
                        }
                        else
                        {
                            var name1 = str1 + " " + "(" + "\(attendence)" + ")"
                            cell.PartnerLabel.text = name1
                        }
                        
                     }
                     else
                     {
                       cell.PartnerLabel.text = str1
                    }
                    
                    cell.checkBoxButton.isEnabled = true
                   
                }
                
//            }
//            else
//            {
//                var name1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
//                cell.checkBoxButton.isEnabled = true
//                cell.PartnerLabel.text = name1
//            }
            
            
        }
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClick), for: .touchUpInside)
        if indexPath.section != 0
        {
            cell.leftConst.constant = 48
            if selectedRow == indexPath.row
            {
                cell.checkBoxButton.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
            else
            {
                
                cell.checkBoxButton.setImage(UIImage(named: "unCheck-1"), for: .normal)
                
            }
        }
        else
        {
            cell.leftConst.constant = 15
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EditGuestViewController") as! EditGuestViewController
//
//       // let dict =  GuestListArray.object(at: indexPath.section) as! NSDictionary
//        var dict = self.GuestListArray.object(at: indexPath.section) as! NSDictionary
//
//        if let memeberArray = dict.value(forKey: "member") as? NSArray
//        {
//            var dict1 = memeberArray.object(at: indexPath.row) as! NSDictionary
////            var name1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
//
//            vc.GuestDetails = dict1
//        }
//
//
//
//
//
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headercell = Bundle.main.loadNibNamed("HeaderGuestListTableCell", owner: self, options: nil)?.first as! HeaderGuestListTableCell
        
        
        
        var dict = self.GuestListArray.object(at: section) as! NSDictionary
        
        if let group_name = dict.value(forKey: "group_name") as? String
        {
            headercell.CoupleLabel.text = group_name
        }
        
     
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
        if let subData = dict.value(forKey: "member") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        //   headercell.GuestLabel.text = titleArray1[section]
        headercell.HeaderBtn.tag = section
        
        if selectedSection == section
        {
           headercell.HeaderBtn.setImage(UIImage(named: "upArrow2"), for: .normal)
        }
        else
        {
        
            headercell.HeaderBtn.setImage(UIImage(named: "downArraow"), for: .normal)
            
        }
        headercell.HeaderBtn.addTarget(self, action: #selector(HeaderClick), for: .touchUpInside)
        headercell.AllClick.tag = section
       headercell.AllClick.addTarget(self, action: #selector(AllClick), for: .touchUpInside)

        return headercell
    }
    
    
    
    @objc func checkBoxButtonClick(_ sender: UIButton)
    {
        if sender.tag == selectedRow
        {
            self.selectedRow = -1
             buttomDialog.isHidden = true
            if sender.isSelected == true
            {
                sender.isSelected = false
                buttomDialog.isHidden = false
                sender.setImage(UIImage(named: "unCheck-1"), for: .normal)
            }
            else
            {
                sender.isSelected = true
                buttomDialog.isHidden = true
                sender.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
        }
        else
        
        {
            self.selectedRow = sender.tag
            
            if sender.isSelected == true
            {
                sender.isSelected = false
                buttomDialog.isHidden = true
                sender.setImage(UIImage(named: "unCheck-1"), for: .normal)
            }
            else
            {
                sender.isSelected = true
                buttomDialog.isHidden = false
                sender.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
        }
       
      self.GuestListTable.reloadData()
    }
    
    @objc func HeaderClick(_ sender: UIButton)
    {
        self.buttomDialog.isHidden = true
        
        if selectedSection == sender.tag
        {
            self.selectedSection = -1
            if self.subArray.count>0
            {
                self.subArray.removeAllObjects()
            }
             GuestListTable.reloadData()
        }
        else
        {
        selectedSection = sender.tag
          var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
        if let subData = dict.value(forKey: "member") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        }
        GuestListTable.reloadData()
    }
    @objc func AllClick(_ sender: UIButton)
    {
        
        
        self.buttomDialog.isHidden = true
        
        if selectedSection == sender.tag
        {
            self.selectedSection = -1
            if self.subArray.count>0
            {
                self.subArray.removeAllObjects()
            }
            GuestListTable.reloadData()
        }
        else
        {
            selectedSection = sender.tag
            var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
            if self.subArray.count>0
            {
                self.subArray.removeAllObjects()
            }
            
            
            if let subData = dict.value(forKey: "member") as? NSArray
            {
                self.subArray = subData.mutableCopy() as! NSMutableArray
                
            }
        }
        GuestListTable.reloadData()
        
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EditGuestViewController") as! EditGuestViewController
//
//        let dict =  GuestListArray.object(at: sender.tag) as! NSDictionary
//        vc.GuestDetails = dict
//
//
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func Next(_ sender: Any) {
    }
    
    @IBAction func Back(_ sender: Any)
    {
        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //        // vc.hideMainView = ""
        //        let navVC = UINavigationController.init(rootViewController: vc)
        //        navVC.setNavigationBarHidden(true, animated: true)
        //        SCANNERDATA = "X"
        //        if let window = UIApplication.shared.windows.first
        //        {
        //            window.rootViewController = navVC
        //            window.makeKeyAndVisible()
        //        }
        
        
        //NotificationCenter.default.post(name: Notification.Name("DidSelectCollection"), object: self)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addGeustList(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddGuestViewController") as! AddGuestViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func GetGestListAPI()
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
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "event_id":eventID,
                "event_type":eventType
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:AllGuestURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.GuestListArray = data.mutableCopy() as! NSMutableArray
                    
                  
                    var FIRSTNAME = "Amar1"
                    
                    if let FIRSTNAME1 = DEFAULT.value(forKey: "FIRSTNAME") as? String
                    {
                        FIRSTNAME = FIRSTNAME1
                    }
                    
                    var SECNAME = "Amar2"
                    
                    if let FIRSTNAME2 = DEFAULT.value(forKey: "SECONDNAME") as? String
                    {
                        SECNAME = FIRSTNAME2
                    }
                    var PersonNAME = "Amar2"
                    
                    if let PERSONNAME = DEFAULT.value(forKey: "PERSONNAME") as? String
                    {
                        PersonNAME = PERSONNAME
                    }
                    
                    if eventType == "wedding"
                    {
                        var Subdict = NSMutableDictionary()
                        
                        
                        var memberArray = NSMutableArray()
                        
                        var Subdict2 = NSMutableDictionary()
                        Subdict2.setValue(FIRSTNAME, forKey: "FIRSTNAME")
                       // Subdict2.setValue("Dev", forKey: "last_name")
                        Subdict2.setValue("attend", forKey: "attendence")
                        
                        var Subdict3 = NSMutableDictionary()
                        Subdict3.setValue(SECNAME, forKey: "FIRSTNAME")
                       // Subdict3.setValue("Dev", forKey: "last_name")
                        Subdict3.setValue("attend", forKey: "attendence")
                        
                        memberArray.add(Subdict2)
                        memberArray.add(Subdict3)
                        
                        Subdict.setValue("Couple", forKey: "group_name")
                        
                        Subdict.setValue(memberArray, forKey: "member")
                        
                        self.GuestListArray.add(Subdict)
                    }
                    else
                    {
                        var Subdict = NSMutableDictionary()
                        
                        
                        var memberArray = NSMutableArray()
                        
                        var Subdict2 = NSMutableDictionary()
                        Subdict2.setValue(PersonNAME, forKey: "FIRSTNAME")
                        // Subdict2.setValue("Dev", forKey: "last_name")
                        Subdict2.setValue("attend", forKey: "attendence")
                        
                        memberArray.add(Subdict2)
                       
                        
                        Subdict.setValue("Person Name", forKey: "group_name")
                        
                        Subdict.setValue(memberArray, forKey: "member")
                        
                        self.GuestListArray.add(Subdict)
                    }
                    
                    
                    
                    var count:Int = 0
                      var Totalcount:Int = 0
                    //print("Gust list after add =\(self.GuestListArray)")
                    for i in 0..<self.GuestListArray.count
                        
                    {
                        var dict = self.GuestListArray.object(at: i) as! NSDictionary
                        if let member = dict.value(forKey: "member") as? NSArray
                        {
                            for i in 0..<member.count
                            {
                                var dict2 = member.object(at: i) as! NSDictionary
                                if let attendence = dict2.value(forKey: "attendence") as? String
                                {
                                    if attendence.lowercased() == "attend"
                                    {
                                        count = count + 1
                                    }
                                }

                            }
                            Totalcount = Totalcount+member.count
                        }
                        
                    }
                    var st1 = "\(eventType.capitalized)"+" "+"\(count)"+" out of "
                    var st2  = st1 + "\(Totalcount)" + " Attending"
                    
                    self.Headertitle.text = st2
                    var array = (self.GuestListArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                    
                    self.GuestListArray = array
                    
                    self.GuestListTable.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func DeleteGuestAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
       
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "guest_id":self.guestId,
               
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETEGUESTAPI, parameters: params) { (response, error) in
            if error == nil
            {
                self.buttomDialog.isHidden = true
              
                self.GetGestListAPI()
                
//                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
//                {
//                    self.GuestListArray = data.mutableCopy() as! NSMutableArray
//
//
//
//                    self.GuestListTable.reloadData()
//
//                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    
    
    
    
}




////////////////////////////////////////////
/*
 override func viewDidLoad() {
 super.viewDidLoad()
 budgetTable.delegate = self
 budgetTable.dataSource = self
 self.budgetTable.sectionHeaderHeight = UITableView.automaticDimension
 self.budgetTable.estimatedSectionHeaderHeight = 75
 
 
 
 budgetTable.rowHeight = UITableView.automaticDimension
 self.budgetTable.rowHeight = 75
 selectedSection = -1
 
 }
 
 func numberOfSections(in tableView: UITableView) -> Int {
 return titleArray.count
 }
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 print("selcted section \(selectedSection)")
 if selectedSection != -1
 {
 if selectedSection == section
 {
 return  2
 }
 
 else
 {
 return 0
 }
 }
 else
 {
 return 0
 }
 
 
 }
 
 func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
 return UITableView.automaticDimension
 }
 
 private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> CGFloat?{
 return UITableView.automaticDimension
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
 {
 let cell = Bundle.main.loadNibNamed("budgetRowCellTableViewCell", owner: self, options: nil)?.first as! budgetRowCellTableViewCell
 
 return cell
 
 }
 func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
 
 
 
 let headercell = Bundle.main.loadNibNamed("NewBudgetCellTableViewCell", owner: self, options: nil)?.first as! NewBudgetCellTableViewCell
 
 headercell.title.text = titleArray[section]
 headercell.arrowBtn.tag = section
 
 headercell.arrowBtn.addTarget(self, action: #selector(arrowClick), for: .touchUpInside)
 //        let dict = self.dataArray.object(at: section) as! NSDictionary
 //        print(dict)
 //
 //        if let name = dict.value(forKey: "name") as? String{
 //
 //            headercell.headerButton.setTitle(name, for:.normal )
 //        }
 //        headercell.clickedButtonHeader.tag = section
 //        headercell.clickedButtonHeader.addTarget(self, action: #selector(self.showdata), for: .touchUpInside)
 
 if  selectedSection == section
 {
 headercell.arrowBtn.setImage(UIImage(named: "Budget"), for: .normal)
 //headercell.clickedButtonHeader.setImage(UIImage(named: "fillCircle"), for: .normal)
 //            if let name = dict.value(forKey: "name") as? String{
 //
 //                self.selectedProfession = name
 //                //self.selectedProfession1 = ""
 //            }
 }
 else{
 headercell.arrowBtn.setImage(UIImage(named: "dropdown-errow"), for: .normal)
 //            headercell.clickedButtonHeader.setImage(UIImage(named: "BlankCircle"), for: .normal)
 }
 
 return headercell
 }
 */


