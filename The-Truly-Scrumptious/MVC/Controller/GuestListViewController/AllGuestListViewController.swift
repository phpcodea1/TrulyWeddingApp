//
//  AllGuestListViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 20/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import  Foundation

class AllGuestListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate
{
   
    //for dialog
    
    @IBOutlet weak var blurView: UIView!
    

    @IBOutlet weak var popUpTable: UITableView!
    @IBOutlet weak var tableBackgroundView: UIView!
    @IBOutlet weak var createListUiView: UIView!
    
    @IBOutlet weak var createMenuUiView: UIView!
    
    @IBOutlet weak var createTableUiView: UIView!
    
    
    // for menu
       @IBOutlet var menuNameTxt: UITextField!
        var menuArray = NSMutableArray()
       var GuestDetails = NSDictionary()
       var menu_id = ""
    
    //for table
    
    var guestId = ""
    
    var tableArray = NSMutableArray()
     @IBOutlet var tableTypeSegm: UISegmentedControl!
    @IBOutlet var noOfSeatTxt: UITextField!
     @IBOutlet var tableNameTxt: UITextField!
     var table_id = ""
    @IBOutlet var seatView: UIView!
    
    
    // for list
    
       var listArray = NSMutableArray()
       @IBOutlet var listNameTxt: UITextField!
        var list_id = ""
    
    @IBOutlet weak var segmOutlet: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
     var GuestListArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
         self.blurView.isHidden = true
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
           GetGestListAPI()
        }
        
      
        tableView.register(UINib(nibName: "AllGuestTableViewCell", bundle: nil), forCellReuseIdentifier: "AllGuestTableViewCell")
       
        self.segmOutlet.clipsToBounds = true
        self.tableBackgroundView.isHidden = true
        
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        
        self.segmOutlet.layer.cornerRadius = segmOutlet.frame.height/2
        self.segmOutlet.layer.borderColor = BORDERCOLOR.cgColor
        self.segmOutlet.layer.borderWidth = 1
        self.segmOutlet.layer.masksToBounds = true
        
        self.tableTypeSegm.layer.cornerRadius = tableTypeSegm.frame.height/2
        self.tableTypeSegm.layer.borderColor = BORDERCOLOR.cgColor
        self.tableTypeSegm.layer.borderWidth = 1
        self.tableTypeSegm.layer.masksToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self // This is not required
        blurView.addGestureRecognizer(tap)
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.seatViewClick))
        Img1.delegate = self // This is not required
        seatView.addGestureRecognizer(Img1)
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
             self.GetListAPI()
            DispatchQueue.main.async
                {
                self.GetMenuListAPI()
            }
           
            
            self.GetTableListAPI()
        }
       
    }
    @objc func handleTap()
    {
        blurView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if self.segmOutlet.selectedSegmentIndex == 0
        {
            self.createListUiView.isHidden = false
            self.createMenuUiView.isHidden = true
            self.createTableUiView.isHidden = true
        }
        else if self.segmOutlet.selectedSegmentIndex == 1
        {
            self.createListUiView.isHidden = true
            self.createMenuUiView.isHidden = false
            self.createTableUiView.isHidden = true
        }
        else
        {
            self.createListUiView.isHidden = true
            self.createMenuUiView.isHidden = true
            self.createTableUiView.isHidden = false
        }
    }
    @objc func seatViewClick()
    {
        
        let optionMenu = UIAlertController(title: nil, message: "Select No of Seat", preferredStyle: .actionSheet)
        
        let saveAction1 = UIAlertAction(title: "1", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "1"
            print("Saved")
        })
        
        let saveAction2 = UIAlertAction(title: "2", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Deleted")
            self.noOfSeatTxt.text = "2"
        })
        
        let saveAction3 = UIAlertAction(title: "3", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "3"
        })
        
        let saveAction4 = UIAlertAction(title: "4", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "4"
            print("Deleted")
        })
        
        let saveAction5 = UIAlertAction(title: "5", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "5"
            print("Saved")
        })
        let saveAction6 = UIAlertAction(title: "6", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "6"
            print("Deleted")
        })
        
        let saveAction7 = UIAlertAction(title: "7", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "7"
            print("Deleted")
        })
        
        let saveAction8 = UIAlertAction(title: "8", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "8"
            print("Saved")
        })
        let saveAction9 = UIAlertAction(title: "9", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "9"
            print("Deleted")
        })
        
        let saveAction10 = UIAlertAction(title: "10", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.noOfSeatTxt.text = "10"
            print("Deleted")
        })
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:
        {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        optionMenu.addAction(saveAction1)
        optionMenu.addAction(saveAction2)
        optionMenu.addAction(saveAction3)
        optionMenu.addAction(saveAction4)
        optionMenu.addAction(saveAction5)
        optionMenu.addAction(saveAction6)
        optionMenu.addAction(saveAction7)
        optionMenu.addAction(saveAction8)
        optionMenu.addAction(saveAction9)
        optionMenu.addAction(saveAction10)
        
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    // for menu
    
    @IBAction func saveMenuList(_ sender: UIButton)
    {
        blurView.isHidden  = true
        
        if (menuNameTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
            if CheckInternet.Connection()
            {
                ADDMenuListAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
    }
    
    func ADDMenuListAPI()
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
                "event_id":eve,
                "event_type":EventType ?? "",
                "menu_name":menuNameTxt.text!
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDmenuURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                self.GetMenuListAPI()
                
                //                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                //                {
                //                    self.menuArray = data.mutableCopy() as! NSMutableArray
                //                    self.tableView.reloadData()
                //
                //                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func GetMenuListAPI()
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
        WebService.shared.apiDataPostMethod(url:menuURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.menuArray = data.mutableCopy() as! NSMutableArray
                    
                    
                    for i in 0..<self.menuArray.count
                    {
                        //var dict = self.menuArray.object(at: i) as! NSDictionary
                       // var id = dict.value(forKey: "id") as! String
//                        if self.GuestDetails.value(forKey: "menu_id") as! String == id
//                        {
//                            self.menu_id = id
//                            self.menuNameTxt.text = dict.value(forKey: "menu_name") as! String
//                          //  self.selectMenuTitle.setTitle(dict.value(forKey: "menu_name") as! String, for: .normal)
//                        }

                        
                    }
                    self.tableView.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    // table action
    @IBAction func saveMenuAct(_ sender: UIButton)
    {
        blurView.isHidden  = true
        
        if (tableNameTxt.text?.count == 0) || (noOfSeatTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
            if CheckInternet.Connection()
            {
                ADDTableListAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    
    func ADDTableListAPI()
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
        var table_type = "1"
        if tableTypeSegm.selectedSegmentIndex == 0
        {
            table_type = "1"
        }
        else if tableTypeSegm.selectedSegmentIndex == 1
        {
            table_type = "2"
        }
        else if tableTypeSegm.selectedSegmentIndex == 2
        {
            table_type = "3"
        }
        else
        {
            table_type = "4"
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "event_id":eventID,
                "event_type":eventType,
                "table_name":tableNameTxt.text!,
                "table_type":table_type,
                "table_seats":noOfSeatTxt.text!
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDtableURL, parameters: params) { (response, error) in
            if error == nil
            {
                self.GetTableListAPI()
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.tableArray = data.mutableCopy() as! NSMutableArray
                    self.tableView.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"time out")
                
            }
            
        }
    }
    
    
    func GetTableListAPI()
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
        WebService.shared.apiDataPostMethod(url:tableURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.tableArray = data.mutableCopy() as! NSMutableArray
                    
                    for i in 0..<self.tableArray.count
                    {
                       // var dict = self.tableArray.object(at: i) as! NSDictionary
                       // var id = dict.value(forKey: "id") as! String
//                        if self.GuestDetails.value(forKey: "table_id") as! String == id
//                        {
//                            self.table_id = id
//                            self.tableNameTxt.text = dict.value(forKey: "table_name") as! String
//                           // self.selectTableTitle.setTitle(dict.value(forKey: "table_name") as! String, for: .normal)
//                        }
//
                        
                    }
                    self.tableView.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    // for list
    @IBAction func saveNewList(_ sender: UIButton)
    {
        blurView.isHidden = true
        self.tableBackgroundView.isHidden = false
        if (listNameTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
            if CheckInternet.Connection()
            {
                ADDListAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    func ADDListAPI()
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
                "list_name":listNameTxt.text!,
                "event_id":eventID,
                "event_type":eventType
                
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDlistURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                self.GetListAPI()
                
                //                if let eventDataArray = (response as! NSDictionary).value(forKey: "event_data") as? NSArray
                //                {
                //                    if let eventDict = eventDataArray.object(at: 0) as? NSDictionary
                //                    {
                //                        defaultValues.set(eventDict.value(forKey: ""), forKey: "event_type")
                //                    }
                //
                //                }
                //                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                //                {
                //                    self.listArray = data.mutableCopy() as! NSMutableArray
                //                    self.tableView.reloadData()
                //
                //                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Time out")
                
            }
            
        }
    }
    func GetListAPI()
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
        WebService.shared.apiDataPostMethod(url:listURL, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.listArray = data.mutableCopy() as! NSMutableArray
                    for i in 0..<self.listArray.count
                    {
//                        var dict = self.listArray.object(at: i) as! NSDictionary
//                        var id = dict.value(forKey: "id") as! String
//                        if self.GuestDetails.value(forKey: "list_id") as! String == id
//                        {
//                            self.list_id = id
//                            self.listNameTxt.text = dict.value(forKey: "list_name") as! String
//                          //  self.selectListTitle.setTitle(dict.value(forKey: "list_name") as! String, for: .normal)
//                        }
                        
                        
                    }
                    self.tableView.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Time out")
                
            }
            
        }
    }
    @IBAction func addGuest(_ sender: UIButton)
    {
       self.blurView.isHidden = false
    }
    @IBAction func segmentAction(_ sender: UISegmentedControl)
    {
        if sender.selectedSegmentIndex == 0
        {
            self.createListUiView.isHidden = false
            self.createMenuUiView.isHidden = true
            self.createTableUiView.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1
        {
            self.createListUiView.isHidden = true
            self.createMenuUiView.isHidden = false
            self.createTableUiView.isHidden = true
        }
        else
        {
            self.createListUiView.isHidden = true
            self.createMenuUiView.isHidden = true
            self.createTableUiView.isHidden = false
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func goBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return GuestListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGuestTableViewCell") as! AllGuestTableViewCell
        
        cell.removeBtn.tag = indexPath.row
        
        cell.removeBtn.addTarget(self, action: #selector(removeBtnAction), for: .touchUpInside)
        var dict = self.GuestListArray.object(at: indexPath.row) as! NSDictionary
        if let name1 = dict.value(forKey: "first_name") as? String
        {
            if let name2 = dict.value(forKey: "last_name") as? String
            {
                cell.nameLbl.text = name1 + " " + name2  //"Guest Name : " +  name1 + " " + name2
            }
         
        }
        if let name2 = dict.value(forKey: "list_name") as? String
        {
            if name2 == ""
            {
                 cell.firstLbl.text = "Not assign"
            }
            else
            
            {
              cell.firstLbl.text =  name2
            }
            
        }
        else
        {
            cell.firstLbl.text = "Not assign"
        }
        if let name2 = dict.value(forKey: "menu_name") as? String
        {
         
            if name2 == ""
            {
                cell.secondLbl.text = "Not assign"
            }
            else
                
            {
                cell.secondLbl.text =  name2
            }
        }
        else
        {
            cell.secondLbl.text = "Not assign"
        }
        if let name2 = dict.value(forKey: "table_name") as? String
        {
      
            if name2 == ""
            {
                cell.thirdLbl.text = "Not assign"
            }
            else
                
            {
                cell.thirdLbl.text =  name2
            }
        }
        else
        {
            cell.thirdLbl.text = "Not assign"
        }
       //
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
                let vc = storyboard?.instantiateViewController(withIdentifier: "EditGuestViewController") as! EditGuestViewController
        
         var dict = self.GuestListArray.object(at: indexPath.row) as! NSDictionary
        
        
        
//               // let dict =  GuestListArray.object(at: indexPath.section) as! NSDictionary
//                var dict = self.GuestListArray.object(at: indexPath.section) as! NSDictionary
//
//                if let memeberArray = dict.value(forKey: "member") as? NSArray
//                {
//                    var dict1 = memeberArray.object(at: indexPath.row) as! NSDictionary
//        //            var name1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
//
//                    vc.GuestDetails = dict1
//                }
        
        vc.GuestDetails = dict
        
        
        
        
                self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func removeBtnAction(_ sender:UIButton)
    {
    var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
        
     self.guestId = dict.value(forKey: "id") as! String
    
    
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
//    func GetGestListAPI()
//    {
//        var userEmail = ""
//        if let email = DEFAULT.value(forKey: "email") as? String
//        {
//            userEmail = email
//        }
//        var eventType = "wedding"
//        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
//        {
//            eventType = eventType1
//        }
//        var eventID = "1"
//        if let eventType1 = DEFAULT.value(forKey: "eventID") as? String
//        {
//            eventID = eventType1
//        }
//
//        let params:[String:Any] =
//            [
//                "email":userEmail,
//                "event_id":eventID,
//                "event_type":eventType
//        ]
//
//
//        print(params)
//        WebService.shared.apiDataPostMethod(url:FULLGUESTAPI, parameters: params) { (response, error) in
//            if error == nil
//            {
//
//
//                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
//                {
//                     self.GuestListArray = data.mutableCopy() as! NSMutableArray
//
//
////                    for i in 0..<GuestListArray1.count
////                    {
////                        var dict = GuestListArray1.object(at: i) as! NSDictionary
////
////                        var listName = ""
////                        var tableName = ""
////                        var menuName = ""
////                        if let name2 = dict.value(forKey: "list_name") as? String
////                        {
////                           listName =  name2
////                        }
////                        if let name2 = dict.value(forKey: "menu_name") as? String
////                        {
////                           menuName =  name2
////                        }
////                        if let name2 = dict.value(forKey: "table_name") as? String
////                        {
////                            tableName =  name2
////                        }
////
////                        if listName != "" && menuName != "" && tableName != ""
////                        {
////                            self.GuestListArray.add(dict)
////                        }
////                    }
////
////                    var st1 = "\(eventType.capitalized)"+" "+"\(count)"+" out of "
////                    var st2  = st1 + "\(Totalcount)" + " Attending"
////
////                    self.Headertitle.text = st2
//                 var array = (self.GuestListArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
//
//                   self.GuestListArray = array
//
//                    self.tableView.reloadData()
//
//                }
//
//            }
//            else
//            {
//               // Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
//
//            }
//
//        }
//    }
    
    func GetGestListAPI()
    {
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        
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
        
        //        let params:[String:Any] = [
        //            "email":"tester757411@gmail.com",
        //            "event_id":"9",
        //            "event_type":"celebration"
        //        ]
        //
        
        print(params)
        print("para in save = \(params)")
        Alamofire.request(FULLGUESTAPI, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseString
            {
                response in
                switch response .result {
                case .success:
                    
                    
                    var a = response.result.value as! String
                    var b = response.result.value as! String
                    var data = a.replacingOccurrences(of: " ", with: "")
                    var data2 = b.replacingOccurrences(of: "null", with: "")
                    
                    
                    if let data = data.data(using: String.Encoding.utf8)
                    {
                        print("data in \(data)")
                        do {
                            if let dict = try JSONSerialization.jsonObject(with: data, options:.mutableLeaves) as? [String: Any]
                            {
                                print("dic t converted \(dict)")
                                if(dict["message"] as! String == "successfully")
                                {
                                    
                                    if let data = dict["data"] as? NSArray
                                    {
                                       // self.mainArray = data.mutableCopy() as! NSMutableArray
                                        
                                        self.GuestListArray = data.mutableCopy() as! NSMutableArray
                                    }
                                    
                                    
                                    // self.mainArray = (self.mainArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                                                     var array = (self.GuestListArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                                    
                                                       self.GuestListArray = array
                                    
                                                        self.tableView.reloadData()
                                    
                                }
                         
                            }
                            
                            
                            
                            
                            SVProgressHUD.dismiss()
                        }
                        catch
                        {
                            SVProgressHUD.dismiss()
                            
                        }
                    }
                    else
                    {
                        print("else resp \(response)")
                    }
                    
                    
                    
                    
                    SVProgressHUD.dismiss()
                    
                case .failure(let error):
                    
                    print(error)
                    SVProgressHUD.dismiss()
                }
                // SVProgressHUD.dismiss()
        }
        
        // SVProgressHUD.dismiss()
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
              
                
                self.GetGestListAPI()
                
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
}
