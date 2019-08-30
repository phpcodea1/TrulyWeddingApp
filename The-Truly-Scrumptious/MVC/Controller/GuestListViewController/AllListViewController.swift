//
//  AllListViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class AllListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var nodataLbl: UILabel!
    
    // for picker
    
    @IBOutlet var UiViewOfPicker: UIView!
    @IBOutlet var pickerView: UIPickerView!
    var pickerSelectedValue = ""
    var pickerSelectedCatId = ""
    var MoveGuestId = ""
    var GuestListArray2 = NSMutableArray()
    var MoveTableId = ""
    
    var ListArray = NSMutableArray()
    
    var selectedSection2 = Int()
    var selectedSection3 = Int()
    var selectedSection = Int()
    var selectedRow = Int()
    var GuestListArray = NSMutableArray()
    var subArray = NSMutableArray()
    
    @IBOutlet weak var listTable: UITableView!
    var guestId = ""
    
    var fromBack = ""
    
    var eventType = ""
    //for dialog
     @IBOutlet weak var headeRView: UIView!
    @IBOutlet weak var blurView: UIView!
    //for list
     @IBOutlet var listNameTxt: UITextField!
    
    
    // for edit delete
    var edit_menu_id = ""
    
    var fromEdit = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nodataLbl.isHidden = true
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            GetListAPI()
        }
        
        self.selectedSection = -1
        self.selectedRow  = -1
        self.UiViewOfPicker.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self // This is not required
        blurView.addGestureRecognizer(tap)
        self.blurView.isHidden = true
        headeRView.clipsToBounds = true
        headeRView.layer.cornerRadius = 10
        headeRView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    @objc func handleTap()
    {
        blurView.isHidden = true
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveNewList(_ sender: UIButton)
    {
       
      
        if (listNameTxt.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter list name")
        }
        else
        {
            if CheckInternet.Connection()
            {
                
                if self.fromEdit == "yes"
                {
                    self.EditListAPI()
                }
                else
                {
                    ADDListAPI()
                }
                
                
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
    }
    // for list
    
    
    @IBAction func addNewTable(_ sender: UIButton)
    {
        self.fromEdit = "no"
        self.listNameTxt .text = ""
        blurView.isHidden = false
    }
    @IBAction func closeAddPopup(_ sender: UIButton)
    {
        blurView.isHidden = true
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
                 self.blurView.isHidden = true
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
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return ListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        print("selcted section \(selectedSection)")
        var dict = self.ListArray.object(at: section) as! NSDictionary
        
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
        
        var dict = self.ListArray.object(at: indexPath.section) as! NSDictionary
         cell.checkBoxButton.isHidden = true
        cell.leftConst.constant = 8
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
        
//        if selectedRow == indexPath.row
//        {
//            cell.checkBoxButton.setImage(UIImage(named: "Checkbox"), for: .normal)
//        }
//        else
//        {
//
//            cell.checkBoxButton.setImage(UIImage(named: "unCheck-1"), for: .normal)
//
//        }
//        cell.checkBoxButton.tag = indexPath.row
//        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonClick), for: .touchUpInside)
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
        
        
        
        var dict = self.ListArray.object(at: section) as! NSDictionary
        
        if let group_name = dict.value(forKey: "list_name") as? String
        {
            headercell.CoupleLabel.text = group_name
        }
        
        if section == 0
        {
            headercell.topLine.isHidden = true
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
            listTable.reloadData()
        }
        else
        {
            selectedSection = sender.tag
//                        var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
//                        if self.subArray.count>0
//                        {
//                            self.subArray.removeAllObjects()
//                        }
//
//
//                        if let subData = dict.value(forKey: "member") as? NSArray
//                        {
//                            self.subArray = subData.mutableCopy() as! NSMutableArray
//
//                        }
        }
        listTable.reloadData()
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
            listTable.reloadData()
        }
        else
        {
            selectedSection = sender.tag
//                        var dict = self.GuestListArray.object(at: sender.tag) as! NSDictionary
//                        if self.subArray.count>0
//                        {
//                            self.subArray.removeAllObjects()
//                        }
//
//
//                        if let subData = dict.value(forKey: "member") as? NSArray
//                        {
//                            self.subArray = subData.mutableCopy() as! NSMutableArray
//
//                        }
        }
        listTable.reloadData()
        
        
    }
    @objc func EditClick(_ sender: UIButton)
    {
        self.fromEdit = "yes"
        self.blurView.isHidden = false
        
        selectedSection = sender.tag
        var dict = self.ListArray.object(at: sender.tag) as! NSDictionary
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        if let list_name = dict.value(forKey: "list_name") as? String
        {
            self.listNameTxt.text = list_name
            
        }
        if let table_id = dict.value(forKey: "list_id") as? String
        {
            self.edit_menu_id = table_id
            
        }
        
       
        
        
        
    }
    @objc func DeleteClick(_ sender: UIButton)
    {
        
        
        selectedSection = sender.tag
        
        
        var dict = self.ListArray.object(at: self.selectedSection) as! NSDictionary
        
        
        
        let optionMenu = UIAlertController(title: "Alert!", message: "Are you sure you want to delete?", preferredStyle: .alert)
        
        if let table_id = dict.value(forKey: "list_id") as? String
        {
            self.edit_menu_id = table_id
            
        }
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                 self.DeleteListAPI()
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
    // for picker
    
    @IBAction func cancelPicker(_ sender: UIButton)
    {
        UiViewOfPicker.isHidden = true
    }
    
    
    @IBAction func donePicker(_ sender: Any)
    {
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
          MoveListAPI()
        }
        
        UiViewOfPicker.isHidden = true
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        var title1 = ""
        if let title = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "list_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        var id1 = ""
        if let id = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "list_id") as? String
        {
            self.pickerSelectedCatId = id
            
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        var title1 = ""
        if let title = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "list_name") as? String
        {
            title1 = title
            
        }
        pickerSelectedValue = title1
        if let id = (self.GuestListArray2.object(at: row) as! NSDictionary).value(forKey: "list_id") as? String
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
        var dict3 = self.ListArray.object(at: selectedSection) as! NSDictionary
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
        if let subData = dict3.value(forKey: "member") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        if selectedRow != -1
        {
            if let dict2 = self.subArray.object(at: selectedRow) as? NSDictionary
            {
                if let id = dict2.value(forKey: "id") as? String
                {
                    
                    self.MoveGuestId = id
                }
            }
            
        }
        
        var dict = self.ListArray.object(at: self.selectedSection) as! NSDictionary
        var table_name1 = dict.value(forKey: "list_name") as! String
        
        
        for i in 0..<self.ListArray.count
        {
            var dict2 = self.ListArray.object(at: i) as! NSDictionary
            
            if dict2.value(forKey: "list_name") as! String == table_name1
            {
                
            }
            else
            {
                self.GuestListArray2.add(dict2)
            }
        }
        
        self.pickerView.reloadAllComponents()
        
        self.listTable.reloadData()
        
        
        
    }
    func showPicker()
    {
        
        if self.ListArray.count>1
        {
        
        
        let optionMenu = UIAlertController(title: "Are you sure want to move table!", message: "If yes ! Please select other table", preferredStyle: .alert)
        
        
        
        let deleteAction = UIAlertAction(title: "Yes", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            self.UiViewOfPicker.isHidden = false
            
        })
        let deleteAction2 = UIAlertAction(title: "Cancel", style: .default, handler:
        {
            (alert: UIAlertAction!) -> Void in
            
            self.selectedRow = -1
            self.listTable.reloadData()
            self.UiViewOfPicker.isHidden = true
        })
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(deleteAction2)
        
        self.present(optionMenu, animated: true, completion: nil)
        }
        else
            
        {
            let optionMenu = UIAlertController(title: "Alert!", message: "There is no another List to move", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Ok", style: .default, handler:
            {
                (alert: UIAlertAction!) -> Void in
                
                self.selectedRow = -1
                self.listTable.reloadData()
                
            })
            
            optionMenu.addAction(deleteAction)
            
            
            self.present(optionMenu, animated: true, completion: nil)
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
        WebService.shared.apiDataPostMethod(url:GETLISTDATA, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.ListArray = data.mutableCopy() as! NSMutableArray
                    
                    self.blurView.isHidden = true
                    //for i in 0..<self.tableArray.count
                  //  {
                        // var dict = self.tableArray.object(at: i) as! NSDictionary
                        // var id = dict.value(forKey: "id") as! String
                        //                        if self.GuestDetails.value(forKey: "table_id") as! String == id
                        //                        {
                        //                            self.table_id = id
                        //                            self.tableNameTxt.text = dict.value(forKey: "table_name") as! String
                        //                           // self.selectTableTitle.setTitle(dict.value(forKey: "table_name") as! String, for: .normal)
                        //                        }
                        //
                        
                   // }
                    if self.ListArray.count>0
                    {
                        self.nodataLbl.isHidden = true
                    }
                    else
                        
                    {
                        self.nodataLbl.isHidden = false
                    }
                    self.listTable.reloadData()
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func EditListAPI()
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
                "list_id": self.edit_menu_id,
                "list_name":self.listNameTxt.text!,
                "event_id":eventID,
                "event_type":eventType,
                ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:EDITLIST, parameters: params) { (response, error) in
            if error == nil
            {
                self.blurView.isHidden = true
                
                self.GetListAPI()
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func DeleteListAPI()
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
                "list_id": self.edit_menu_id
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETELIST, parameters: params) { (response, error) in
            if error == nil
            {
                self.blurView.isHidden = true
                self.GetListAPI()
                
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func MoveListAPI()
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
                
                self.listTable.reloadData()
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
}
