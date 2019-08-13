//
//  AllGuestViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AllGuestViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
  // for picker
    
     @IBOutlet var UiViewOfPicker: UIView!
     @IBOutlet var pickerView: UIPickerView!
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    var MoveGuestId = ""
    
    var MoveTableId = ""
    
    
    @IBOutlet weak var Uiview3: UIView!
    @IBOutlet weak var Uiview2: UIView!
        @IBOutlet weak var Uiview1: UIView!
    
    @IBOutlet weak var GuestListTable: UITableView!
    var selectedSection2 = Int()
    var selectedSection3 = Int()
    var selectedSection = Int()
    var selectedRow = Int()
    var GuestListArray = NSMutableArray()
    var GuestListArray2 = NSMutableArray()
    var subArray = NSMutableArray()
    
    var guestId = ""
     @IBOutlet weak var headeRView: UIView!
    
    var fromBack = ""
    
    var eventType = ""
    //for dialog
    
    @IBOutlet weak var blurView: UIView!
    //for table
    
    
   
    var tableArray = NSMutableArray()
    @IBOutlet var tableTypeSegm: UISegmentedControl!
    @IBOutlet var noOfSeatTxt: UITextField!
    @IBOutlet var tableNameTxt: UITextField!
    var table_id = ""
    @IBOutlet var seatView: UIView!
    
   
    
    // for edit and delete
    @IBOutlet weak var buttomDialog: UIView!
     var edit_table_id = ""
    
     var fromEdit = ""
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
            blurView.isHidden = true
        headeRView.clipsToBounds = true
        headeRView.layer.cornerRadius = 10
        headeRView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
             self.GetTableListAPI()
        }
        
       
        
        self.selectedSection = -1
        self.selectedRow  = -1
        self.UiViewOfPicker.isHidden = true
        
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
        
//        let Img4 = UITapGestureRecognizer(target: self, action: #selector(self.View1Click))
//        Img4.delegate = self // This is not required
//        Uiview1.addGestureRecognizer(Img4)
//
//
//        let Img2 = UITapGestureRecognizer(target: self, action: #selector(self.View2Click))
//        Img2.delegate = self // This is not required
//        Uiview2.addGestureRecognizer(Img2)
//
//
//        let Img3 = UITapGestureRecognizer(target: self, action: #selector(self.View3Click))
//        Img3.delegate = self // This is not required
//        Uiview3.addGestureRecognizer(Img3)
        
     
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
   // for table
    
    @IBAction func addNewTable(_ sender: UIButton)
    {
        self.tableNameTxt.text = ""
        self.fromEdit = "no"
         blurView.isHidden = false
    }
    
    
    
    
    @IBAction func closeTablePopUp(_ sender: Any)
    {
        blurView.isHidden = true
    }
    @objc func handleTap()
    {
        blurView.isHidden = true
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
              self.blurView.isHidden = true
                 self.GetTableListAPI()
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    
                    self.GuestListArray = data.mutableCopy() as! NSMutableArray
                    self.GuestListTable.reloadData()
                    
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
        WebService.shared.apiDataPostMethod(url:GETALLTABLEDATA, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.GuestListArray = data.mutableCopy() as! NSMutableArray
                    self.GuestListArray2 = data.mutableCopy() as! NSMutableArray
                    
                    self.blurView.isHidden = true
                  
                    self.GuestListTable.reloadData()
                    
                    self.pickerView.reloadAllComponents()
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    @IBAction func saveTable(_ sender: UIButton)
    {
        if (tableNameTxt.text?.count == 0) || (noOfSeatTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter all details.")
        }
        else
        {
            if CheckInternet.Connection()
            {
                if self.fromEdit == "yes"
                {
                    self.EditTableAPI()
                }
                else
                {
                  self.ADDTableListAPI()
                }
                
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
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
                return self.subArray.count
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
        let cell = Bundle.main.loadNibNamed("NewAllGuestCellTableViewCell", owner: self, options: nil)?.first as! NewAllGuestCellTableViewCell
        
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
                var name2 = name1 //+ " " + "(" + "attend" + ")"
                cell.PartnerLabel.text = name2
                
                cell.checkBoxButton.isHidden = true
                cell.checkBoxButton.isEnabled = false
                cell.checkBoxButton.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
            else
            {
                var str1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
               
                if let  attendence = dict1.value(forKey: "attendence") as? String
                {
                    if attendence == ""
                    {
                        var name1 = str1
                        cell.PartnerLabel.text = name1
                    }
                    else
                    {
                        var name1 = str1 //+ " " + "(" + "\(attendence)" + ")"
                        cell.PartnerLabel.text = name1
                    }
                    
                }
                else
                {
                    cell.PartnerLabel.text = str1
                }
                
            
                
            }
            
            //            }
            //            else
            //            {
            //                var name1 = (dict1.value(forKey: "first_name") as! String) + " " + (dict1.value(forKey: "last_name") as! String)
            //                cell.checkBoxButton.isEnabled = true
            //                cell.PartnerLabel.text = name1
            //            }
            
            
        }
        if selectedRow == indexPath.row
        {
            cell.checkBoxButton.setImage(UIImage(named: "Checkbox"), for: .normal)
        }
        else
        {
            
            cell.checkBoxButton.setImage(UIImage(named: "unCheck-1"), for: .normal)
            
        }
        cell.checkBoxButton.tag = indexPath.row
        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClick), for: .touchUpInside)

        
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
        let headercell = Bundle.main.loadNibNamed("NewAllGuestHeaderCell", owner: self, options: nil)?.first as! NewAllGuestHeaderCell
        
        if section == 0
        {
            headercell.topLine.isHidden = true
        }
       

        
        var dict = self.GuestListArray.object(at: section) as! NSDictionary

        if let group_name = dict.value(forKey: "table_name") as? String
        {
            headercell.CoupleLabel.text = group_name
        }
        
        
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
//        if let subData = dict.value(forKey: "member") as? NSArray
//        {
//            self.subArray = subData.mutableCopy() as! NSMutableArray
//
//        }
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
        
        headercell.editBtn.tag = section
        headercell.editBtn.addTarget(self, action: #selector(EditClick), for: .touchUpInside)
        
        headercell.deleteBtn.tag = section
        headercell.deleteBtn.addTarget(self, action: #selector(DeleteClick), for: .touchUpInside)
        
        return headercell
    }
    
    // for picker
    
    @IBAction func cancelPicker(_ sender: UIButton)
    {
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func donePicker(_ sender: Any)
    {
        
      //  venueTxt.text = pickerSelectedValue
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
           MoveTableAPI()
        }
        
        UiViewOfPicker.isHidden = true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var title1 = ""
        if let title = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "table_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        var id1 = ""
        if let id = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "table_id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var title1 = ""
        if let title = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "table_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        if let id = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "table_id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
        return title1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GuestListArray2.count
    }
    
    @objc func checkBoxButtonClick(_ sender: UIButton)
    {
        
        if self.GuestListArray2.count>0
        {
            self.GuestListArray2.removeAllObjects()
        }
        if sender.tag == selectedRow
        {
            self.selectedRow = -1
           
            if sender.isSelected == true
            {
                sender.isSelected = false
            self.showPicker()
                sender.setImage(UIImage(named: "unCheck-1"), for: .normal)
            }
            else
            {
                sender.isSelected = true
            
                sender.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
        }
        else
            
        {
            self.selectedRow = sender.tag
            
            if sender.isSelected == true
            {
                sender.isSelected = false
             
                sender.setImage(UIImage(named: "unCheck-1"), for: .normal)
            }
            else
            {
                sender.isSelected = true
              self.showPicker()
                sender.setImage(UIImage(named: "Checkbox"), for: .normal)
            }
        }
        var dict3 = self.GuestListArray.object(at: selectedSection) as! NSDictionary
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
        if let subData = dict3.value(forKey: "member") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
       
        if let dict2 = self.subArray.object(at: selectedRow) as? NSDictionary
        {
        if let id = dict2.value(forKey: "id") as? String
        {
            
            self.MoveGuestId = id
        }
        }
        
        var dict = self.GuestListArray.object(at: self.selectedSection) as! NSDictionary
        var table_name1 = dict.value(forKey: "table_name") as! String
        
        
        for i in 0..<self.GuestListArray.count
        {
             var dict2 = self.GuestListArray.object(at: i) as! NSDictionary
           
      if dict2.value(forKey: "table_name") as! String == table_name1
      {

      }
    else
      {
        self.GuestListArray2.add(dict2)
    }
 }
        
        self.pickerView.reloadAllComponents()
        
        self.GuestListTable.reloadData()
        
     
        
    }
    func showPicker()
    {
        
        let optionMenu = UIAlertController(title: "Are you sure you want to move table?", message: "If yes ! Please select other table", preferredStyle: .alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.UiViewOfPicker.isHidden = false
            
        })
        let deleteAction2 = UIAlertAction(title: "Cancel", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.selectedRow = -1
            self.GuestListTable.reloadData()
            self.UiViewOfPicker.isHidden = true
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(deleteAction2)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
 @objc func HeaderClick(_ sender: UIButton)
    {
      
        self.selectedRow = -1
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
        
         self.selectedRow = -1
        
        
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
    @objc func EditClick(_ sender: UIButton)
    {
        self.fromEdit = "yes"
        self.blurView.isHidden = false
        
            selectedSection = sender.tag
            var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
            if self.subArray.count>0
            {
                self.subArray.removeAllObjects()
            }
        if let table_name = dict.value(forKey: "table_name") as? String
        {
          self.tableNameTxt.text = table_name
            
        }
        if let table_seats = dict.value(forKey: "table_seats") as? String
        {
            self.noOfSeatTxt.text = table_seats
            
        }
        if let table_id = dict.value(forKey: "table_id") as? String
        {
           self.edit_table_id = table_id
            
        }
        
        if let table_type = dict.value(forKey: "table_type") as? String
        {
           
            if table_type == "1"
            {
                 tableTypeSegm.selectedSegmentIndex = 0
            }
            else if table_type == "2"
            {
                tableTypeSegm.selectedSegmentIndex = 1
            }
            else if table_type == "3"
            {
                tableTypeSegm.selectedSegmentIndex = 2
            }
                
            else
            {
                tableTypeSegm.selectedSegmentIndex = 2
            }
            
        }
       
        
            if let subData = dict.value(forKey: "member") as? NSArray
            {
                self.subArray = subData.mutableCopy() as! NSMutableArray
                
            }
        
        
        
    }
    @objc func DeleteClick(_ sender: UIButton)
    {
        
        
        selectedSection = sender.tag
      
        
                    let optionMenu = UIAlertController(title: "Alert!", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        
        
                    let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
                    {
                        (alert: UIAlertAction!) -> Void in
                     
                        var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
                       
                        
                        if let table_id = dict.value(forKey: "table_id") as? String
                        {
                            self.edit_table_id = table_id
                            
                        }
                        
                        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
                        {
                            NetworkEngine.networkEngineObj.showInterNetAlert()
                        }
                        else
                        {
                            
                            self.DeleteTableAPI()
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
    
//    @objc func View1Click(_ sender: UIButton)
//    {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "EditGuestViewController") as! EditGuestViewController
//
//        // let dict =  GuestListArray.object(at: indexPath.section) as! NSDictionary
//        var dict = self.GuestListArray.object(at: self.selectedSection) as! NSDictionary
//
//        if let memeberArray = dict.value(forKey: "member") as? NSArray
//        {
//            var dict1 = memeberArray.object(at: self.selectedRow) as! NSDictionary
//
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
//    }
//
//    @objc func View2Click(_ sender: UIButton)
//    {
//        var dict = self.GuestListArray.object(at: self.selectedSection) as! NSDictionary
//
//        if let memeberArray = dict.value(forKey: "member") as? NSArray
//        {
//            var dict1 = memeberArray.object(at: self.selectedRow) as! NSDictionary
//            self.guestId = dict1.value(forKey: "id") as! String
//
//            let optionMenu = UIAlertController(title: "Alert!", message: "Are you sure want to delete?", preferredStyle: .alert)
//
//
//
//            let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
//            {
//                (alert: UIAlertAction!) -> Void in
//              //  self.DeleteGuestAPI()
//
//            })
//            let deleteAction2 = UIAlertAction(title: "Cancel", style: .default, handler:
//            {
//                (alert: UIAlertAction!) -> Void in
//
//
//            })
//            optionMenu.addAction(deleteAction)
//            optionMenu.addAction(deleteAction2)
//
//            self.present(optionMenu, animated: true, completion: nil)
//
//
//        }
//
//    }
//
//    @objc func View3Click(_ sender: UIButton)
//    {
//
//        selectedSection = -1
//        self.GuestListTable.reloadData()
//        buttomDialog.isHidden = true
//    }
    
    func EditTableAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
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
                "table_id": self.edit_table_id,
                "table_type":table_type,
                "table_name":self.tableNameTxt.text!,
                "table_seats":self.noOfSeatTxt.text!,
                "event_id":eventID,
                "event_type":eventType,
                ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:EDITTABLE, parameters: params) { (response, error) in
            if error == nil
            {
              self.blurView.isHidden = true
                
               self.GetTableListAPI()
               
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func DeleteTableAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
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
                "table_id": self.edit_table_id
                ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETETABLE, parameters: params) { (response, error) in
            if error == nil
            {
                self.blurView.isHidden = true
                
                self.GetTableListAPI()
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    
    func MoveTableAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
      
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "table_id": self.pickerSelectedCatId,
                "guest_id": self.MoveGuestId
                
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:MOVETABLE, parameters: params) { (response, error) in
            if error == nil
            {
                self.blurView.isHidden = true
                
                self.GetTableListAPI()
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
}
