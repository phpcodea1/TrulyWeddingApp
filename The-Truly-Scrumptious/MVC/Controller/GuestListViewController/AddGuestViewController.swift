//
//  AddGuestViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 22/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//
    import UIKit
    import IQKeyboardManager
    
    class AddGuestViewController: UIViewController,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource
    {
        
        
        
        @IBOutlet var UiViewOfPicker: UIView!
        @IBOutlet var pickerView: UIPickerView!
        var categoryList = NSMutableArray()
        
        var pickerSelectedValue = ""
        var pickerSelectedCatId = ""
        
        
        
        
        
        @IBOutlet var CNHeader: UILabel!
        @IBOutlet var CNTitle: UIButton!
        
        @IBOutlet var CNtxt: UITextField!
        
        @IBOutlet var tableView: UITableView!
        
        @IBOutlet weak var createBtnTitle: UIButton!
        
        @IBOutlet var tableBackView: UIView!
        
        
        @IBOutlet var tableTypeSegm: UISegmentedControl!
        
        @IBOutlet var createNewTableView: UIView!
        
        @IBOutlet var saveMenuBtn: UIButton!
        
        
        @IBOutlet var createNewTablePopup: UIView!
        
        @IBOutlet var STHeaderView: UIView!
        
        
        @IBOutlet var createListHeader: UIView!
        @IBOutlet var createNewListPopup: UIView!
        
        @IBOutlet var blurView: UIView!
        @IBOutlet var attendSegmt: UISegmentedControl!
        @IBOutlet var adultSegmt: UISegmentedControl!
        @IBOutlet var lineView: UIView!
        
        @IBOutlet var scrollView1: UIScrollView!
        
        @IBOutlet var firstNameTxt: UITextField!
        @IBOutlet var lastNameTxt: UITextField!
        
        
        @IBOutlet var groupInfomation: UITextField!
        var eventType = ""
        var buttonClick = ""
        var listArray = NSMutableArray()
        var menuArray = NSMutableArray()
        var tableArray = NSMutableArray()
        
        var GuestDetails = NSDictionary()
        @IBOutlet var guestView: UIView!
        
        
        
        @IBOutlet var noOfSeatTxt: UITextField!
        @IBOutlet var listNameTxt: UITextField!
        
        @IBOutlet var menuNameTxt: UITextField!
        @IBOutlet var seatView: UIView!
        
        @IBOutlet var downImage: UIImageView!
        @IBOutlet var tableNameTxt: UITextField!
        
        
        
        @IBOutlet var selectListTitle: UIButton!
        
        @IBOutlet var selectMenuTitle: UIButton!
        @IBOutlet var selectTableTitle: UIButton!
        
        // contact info
        
        @IBOutlet var groupNameTxt: UITextField!
        
        
        
        
        @IBOutlet var notes: UITextView!
        
        @IBOutlet var emailTxt: UITextField!
        @IBOutlet var phoneNumberTxt: UITextField!
        @IBOutlet var mobileNameTxt: UITextField!
        
        
        
        @IBOutlet var addressTxt: UITextField!
        @IBOutlet var cityTownTxt: UITextField!
        @IBOutlet var stateTxt: UITextField!
        
        
        @IBOutlet var postalCodeTxt: UITextField!
        
        var table_id = ""
        var menu_id = ""
        var list_id = ""
        
        var guestId = ""
        
        var GroupIdNew = ""
        var fromGropClick = ""
        override func viewDidLoad() {
            super.viewDidLoad()
            var eventType = "wedding"
            if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
            {
                eventType = eventType1
            }
            UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            
            self.tableTypeSegm.layer.cornerRadius = tableTypeSegm.frame.height/2
            self.tableTypeSegm.layer.borderColor = BORDERCOLOR.cgColor
            self.tableTypeSegm.layer.borderWidth = 1
            self.tableTypeSegm.layer.masksToBounds = true
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                
                self.GetListAPI()
                self.GetMenuListAPI()
                self.GetTableListAPI()
            }
            
            
           
            
            blurView.isHidden = true
            
            let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.seatViewClick))
            Img1.delegate = self // This is not required
            seatView.addGestureRecognizer(Img1)
            
            let Img2 = UITapGestureRecognizer(target: self, action: #selector(self.guestViewClick))
            Img2.delegate = self // This is not required
            guestView.addGestureRecognizer(Img2)
            
            UiViewOfPicker.isHidden = true
            UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
            
            // adultSegmt.layer.borderWidth = 1
            //adultSegmt.layer.borderColor = BORDERCOLOR.cgColor
            adultSegmt.layer.cornerRadius = adultSegmt.frame.height/2
            
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
            tap.delegate = self // This is not required
            blurView.addGestureRecognizer(tap)
            
            // attendSegmt.layer.borderWidth = 1
            // attendSegmt.layer.borderColor = BORDERCOLOR.cgColor
            attendSegmt.layer.cornerRadius = attendSegmt.frame.height/2
            
          
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                
               ALLCATEGORYAPI()
            }
            
            lineView.layer.borderWidth = 1
            lineView.layer.borderColor = BORDERCOLOR.cgColor
            
            
            self.adultSegmt.layer.cornerRadius = adultSegmt.frame.height/2
            self.adultSegmt.layer.borderColor = BORDERCOLOR.cgColor
            self.adultSegmt.layer.borderWidth = 1
            self.adultSegmt.layer.masksToBounds = true
            
            
            self.attendSegmt.layer.cornerRadius = attendSegmt.frame.height/2
            self.attendSegmt.layer.borderColor = BORDERCOLOR.cgColor
            self.attendSegmt.layer.borderWidth = 1
            self.attendSegmt.layer.masksToBounds = true
            
            createNewTablePopup.isHidden = true
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            // selectListPopup.isHidden = true
            // Do any additional setup after loading the view.
            
            // selectListPopup.layer.cornerRadius = 5
            
            
            
            createNewTableView.layer.cornerRadius = 5
            createNewTableView.clipsToBounds = true
            
            
            
            createNewListPopup.layer.cornerRadius = 5
            createNewListPopup.clipsToBounds = true
            
            createNewTablePopup.layer.cornerRadius = 5
            createNewTablePopup.clipsToBounds = true
            
            self.tableBackView.isHidden = true
            
            tableView.delegate = self
            tableView.dataSource = self
            self.tableView.sectionHeaderHeight = UITableView.automaticDimension
            self.tableView.estimatedSectionHeaderHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
            self.tableView.rowHeight = 100
            self.buttonClick = ""
            
            print("Guest deatisl here \(GuestDetails)")
            
            if let f_name = GuestDetails.value(forKey: "first_name") as? String
            {
                firstNameTxt.text = f_name
            }
            if let f_name = GuestDetails.value(forKey: "last_name") as? String
            {
                lastNameTxt.text = f_name
            }
            if let f_name = GuestDetails.value(forKey: "group_name") as? String
            {
                groupInfomation.text = f_name
            }
            if let email = GuestDetails.value(forKey: "email") as? String
            {
                emailTxt.text = email
            }
            if let phone_number = GuestDetails.value(forKey: "phone_number") as? String
            {
                phoneNumberTxt.text = phone_number
            }
            if let mobile_number = GuestDetails.value(forKey: "mobile_number") as? String
            {
                mobileNameTxt.text = mobile_number
            }
            if let id = GuestDetails.value(forKey: "id") as? String
            {
                guestId = id
            }
            
            if let address = GuestDetails.value(forKey: "address") as? String
            {
                addressTxt.text = address
            }
            if let city_town = GuestDetails.value(forKey: "city_town") as? String
            {
                cityTownTxt.text = city_town
            }
            if let state = GuestDetails.value(forKey: "state") as? String
            {
                stateTxt.text = state
            }
            if let zipcode = GuestDetails.value(forKey: "zipcode") as? String
            {
                postalCodeTxt.text = zipcode
            }
            if let notes1 = GuestDetails.value(forKey: "notes") as? String
            {
                notes.text = notes1
            }
            
            
            
            
            
            if let age_level = GuestDetails.value(forKey: "age_level") as? String
            {
                
                
                if age_level.lowercased() == "adult"
                {
                    
                    adultSegmt.selectedSegmentIndex = 0
                }
                else if age_level.lowercased() == "child"
                {
                    //                adultSegmt.setEnabled(true, forSegmentAt: 1)
                    adultSegmt.selectedSegmentIndex = 1
                }
                else
                {
                    //adultSegmt.setEnabled(true, forSegmentAt: 2)
                    adultSegmt.selectedSegmentIndex = 2
                }
            }
            if let age_level = GuestDetails.value(forKey: "attendence") as? String
            {
                
                
                if age_level.lowercased() == "cancel"
                {
                    attendSegmt.selectedSegmentIndex = 2
                    
                }
                else if age_level.lowercased() == "Not Attending"
                {
                    //                adultSegmt.setEnabled(true, forSegmentAt: 1)
                    attendSegmt.selectedSegmentIndex = 1
                }
                else
                {
                    //adultSegmt.setEnabled(true, forSegmentAt: 2)
                    attendSegmt.selectedSegmentIndex = 0
                }
            }
            
            
        }
        @IBAction func cancelPicker(_ sender: UIButton)
        {
            UiViewOfPicker.isHidden = true
        }
        
        
        @IBAction func donePicker(_ sender: Any)
        {
            
            self.groupInfomation.text = pickerSelectedValue
            UiViewOfPicker.isHidden = true
        }
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            var title1 = ""
            if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "group_name") as? String
            {
                title1 = title
                
            }
            pickerSelectedValue = title1
            var id1 = ""
            if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
            {
                self.pickerSelectedCatId = id
                
            }
            
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            var title1 = ""
            if let title = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "group_name") as? String
            {
                title1 = title
                
            }
            pickerSelectedValue = title1
            if let id = (self.categoryList.object(at: row) as! NSDictionary).value(forKey: "id") as? String
            {
                self.pickerSelectedCatId = id
                
            }
            self.groupInfomation.text = pickerSelectedValue
            return title1
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return categoryList.count
        }
        
        
        @objc func guestViewClick()
        {
            self.fromGropClick = "yes"
            self.UiViewOfPicker.isHidden = false
            /*
             
             let optionMenu = UIAlertController(title: nil, message: "Select group", preferredStyle: .actionSheet)
             
             let saveAction1 = UIAlertAction(title: "Couples", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Couples"
             print("Saved")
             })
             
             let saveAction2 = UIAlertAction(title: "Family friends of my partner", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             print("Deleted")
             self.groupInfomation.text = "Family friends of my partner"
             })
             
             let saveAction3 = UIAlertAction(title: "Family friends of Rajesh", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Family friends of Rajesh"
             })
             
             let saveAction4 = UIAlertAction(title: "Mutual friends", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Mutual friends"
             print("Deleted")
             })
             
             let saveAction5 = UIAlertAction(title: "Partner's coworkers", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Partner's coworkers"
             print("Saved")
             })
             let saveAction6 = UIAlertAction(title: "Partner's family", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Partner's family"
             print("Deleted")
             })
             
             let saveAction7 = UIAlertAction(title: "Partner's friends", style: .default, handler:
             {
             (alert: UIAlertAction!) -> Void in
             self.groupInfomation.text = "Partner's friends"
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
             
             optionMenu.addAction(cancelAction)
             self.present(optionMenu, animated: true, completion: nil)
             */
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
        
        @IBAction func GroupMenu(_ sender: UIButton) {
        }
        
        @IBAction func createNewTableAct(_ sender: UIButton)
        {
            
            
            createNewTablePopup.isHidden = true
            blurView.isHidden = false
            //  selectListPopup.isHidden = true
            
            
            
            createNewTableView.isHidden = false
        }
        
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
        
        
        
        
        @IBAction func closeCreateMenu(_ sender: UIButton)
        {
            createNewTablePopup.isHidden = true
            self.tableBackView.isHidden = false
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            
        }
        
        @IBAction func goBACK(_ sender: UIButton) {
            self.navigationController?.popViewController(animated: true)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            if buttonClick == "selectmenu"
            {
                return menuArray.count
            }
            else if buttonClick == "selectlist"
            {
                return listArray.count
            }
            else
            {
                return tableArray.count
            }
            
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let cell = Bundle.main.loadNibNamed("EditGuestOptionTableViewCell", owner: self, options: nil)?.first as! EditGuestOptionTableViewCell
            
            cell.selectedOptionBtn.tag = indexPath.row
            cell.selectedOptionBtn.addTarget(self, action: #selector(selectedOptionBtnClick), for: .touchUpInside)
            // cell..text = titleArray1[indexPath.row]
            if buttonClick == "selectlist"
            {
                var dict = self.listArray.object(at: indexPath.row) as! NSDictionary
                
                cell.title.text = dict.value(forKey: "list_name") as! String
            }
            else if buttonClick == "selectmenu"
            {
                var dict = self.menuArray.object(at: indexPath.row) as! NSDictionary
                
                cell.title.text = dict.value(forKey: "menu_name") as! String
            }
            else
            {
                var dict = self.tableArray.object(at: indexPath.row) as! NSDictionary
                
                cell.title.text = dict.value(forKey: "table_name") as! String
            }
            
            return cell
            
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return UITableView.automaticDimension
        }
        @objc func selectedOptionBtnClick(_ sender:UIButton)
        {
            if buttonClick == "selectlist"
            {
                var dict = self.listArray.object(at: sender.tag) as! NSDictionary
                
                
                selectListTitle.setTitle(dict.value(forKey: "list_name") as! String, for: .normal)
                self.list_id = dict.value(forKey: "id") as! String
            }
            else if buttonClick == "selectmenu"
            {
                var dict = self.menuArray.object(at: sender.tag) as! NSDictionary
                
                selectMenuTitle.setTitle(dict.value(forKey: "menu_name") as! String, for: .normal)
                self.menu_id = dict.value(forKey: "id") as! String
            }
            else
            {
                var dict = self.tableArray.object(at: sender.tag) as! NSDictionary
                selectTableTitle.setTitle(dict.value(forKey: "table_name") as! String, for: .normal)
                self.table_id = dict.value(forKey: "id") as! String
            }
            self.blurView.isHidden = true
        }
        // list action
        
        @IBAction func createNewListAct(_ sender: UIButton)
        {
            blurView.isHidden = false
            //selectListPopup.isHidden = true
            
            createNewListPopup.isHidden = false
            
            createNewTablePopup.isHidden = true
        }
        @IBAction func closeNewList(_ sender: Any)
        {
            blurView.isHidden = false
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            //        selectListPopup.isHidden = false
            //
            //        createNewListPopup.isHidden = true
            //        selectTablePopup.isHidden = true
            //        createNewTablePopup.isHidden = true
            
            self.tableBackView.isHidden = false
        }
        
        @IBAction func saveNewList(_ sender: UIButton)
        {
            blurView.isHidden = true
            self.tableBackView.isHidden = false
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
        
        @IBAction func listType(_ sender: UIButton)
        {
            blurView.isHidden = true
            // selectListPopup.isHidden = true
            
            createNewListPopup.isHidden = true
            
            
            createNewTablePopup.isHidden = true
        }
        
        
        
        
        
        @IBAction func selectList(_ sender: UIButton)
        {
            blurView.isHidden = false
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            self.tableBackView.isHidden = false
            self.createBtnTitle.setTitle("Create New List", for: .normal)
            buttonClick = "selectlist"
            
            
            self.tableView.reloadData()
            
            //        selectListPopup.isHidden = false
            //
            //        createNewListPopup.isHidden = true
            //
            //        selectTablePopup.isHidden = true
            //        createNewTablePopup.isHidden = true
            
            
        }
        
        @IBAction func selectTable(_ sender: UIButton)
        {
            blurView.isHidden = false
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            
            buttonClick = "selecttable"
            self.createBtnTitle.setTitle("Create New Table", for: .normal)
            self.tableBackView.isHidden = false
            self.tableView.reloadData()
            //        selectTablePopup.isHidden = false
            //
            //        menuListPopup.isHidden = true
            //        createNewTableView.isHidden = true
            //
            //        selectListPopup.isHidden = true
            //        createNewListPopup.isHidden = true
            //        createNewTablePopup.isHidden = true
            
        }
        
        // menu action
        
        @IBAction func selectMenu(_ sender: UIButton)
        {
            blurView.isHidden = false
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            self.tableBackView.isHidden = false
            self.createBtnTitle.setTitle("Create New Menu", for: .normal)
            buttonClick = "selectmenu"
            self.tableView.reloadData()
            
            //        createNewTableView.isHidden = true
            //
            //        menuListPopup.isHidden = false
            //        selectTablePopup.isHidden = true
            //        createNewTablePopup.isHidden = true
            //        selectListPopup.isHidden = true
            //        createNewListPopup.isHidden = true
        }
        
        
        @IBAction func selectedMenuAct(_ sender: UIButton)
        {
            blurView.isHidden = true
            
            
            createNewListPopup.isHidden = true
            
            createNewTableView.isHidden = true
            
            
            createNewTablePopup.isHidden = true
        }
        
        
        
        @IBAction func createNewMenuAct(_ sender: UIButton)
        {
            
            //createNewTablePopup.isHidden = true
            createNewListPopup.isHidden = false
        }
        
        @IBAction func closeCreateMenu2(_ sender: UIButton)
        {
            createNewTableView.isHidden = true
            createNewListPopup.isHidden = true
            createNewTablePopup.isHidden = true
            createNewTableView.isHidden = true
            self.tableBackView.isHidden = false
        }
        // select list work
        
        
        @IBAction func createAction(_ sender: UIButton)
        {
            if buttonClick == "selectmenu"
            {
                self.tableBackView.isHidden = true
                createNewTablePopup.isHidden = false
                
            }
            else if  buttonClick == "selectlist"
            {
                self.tableBackView.isHidden = true
                createNewListPopup.isHidden = false
                createNewTableView.isHidden = true
                
            }
            else
                
            {
                
                self.tableBackView.isHidden = true
                createNewListPopup.isHidden = true
                createNewTablePopup.isHidden = true
                createNewTableView.isHidden = false
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
                        
                          
                            if self.listArray.count>0
                            {
                                var dict = self.listArray.object(at: 0) as! NSDictionary
                            self.list_id = dict.value(forKey: "id") as! String
                                self.listNameTxt.text = dict.value(forKey: "list_name") as! String
                                self.selectListTitle.setTitle(dict.value(forKey: "list_name") as! String, for: .normal)
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
                        
                        self.blurView.isHidden = true
                        
                        
                         
                            if self.tableArray.count > 0
                            {
                              var dict = self.tableArray.object(at: 0) as! NSDictionary
                                self.tableNameTxt.text = dict.value(forKey: "table_name") as! String
                                self.table_id = dict.value(forKey: "id") as! String
                                self.selectTableTitle.setTitle(dict.value(forKey: "table_name") as! String, for: .normal)
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
        
        
        @IBAction func SaveGuestAction(_ sender: UIButton)
        {
            
            if  (firstNameTxt.text?.count == 0) || (lastNameTxt.text?.count == 0)
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter Name")
            }
//               else if (emailTxt.text?.count == 0)
//            {
//               Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please enter email")
//            }
            else
            {
                if CheckInternet.Connection()
                {
                    self.AddGuestAPI()
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
                        
                        
                       
                        
                        
                            if self.menuArray.count>0
                            {
                                  var dict = self.menuArray.object(at: 0) as! NSDictionary
                                 var id = dict.value(forKey: "id") as! String
                                self.menu_id = id
                               
                                self.menuNameTxt.text = dict.value(forKey: "menu_name") as! String
                                self.selectMenuTitle.setTitle(dict.value(forKey: "menu_name") as! String, for: .normal)
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
        
        func AddGuestAPI()
        {
            var gropId = "1"
//            if  self.fromGropClick == "yes"
//            {
                gropId = self.pickerSelectedCatId
                
//            }
//            else
//            {
//                gropId = self.GroupIdNew
//            }
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
            var userage = "adult"
            if adultSegmt.selectedSegmentIndex == 0
            {
                userage = "Adult"
            }
            else if adultSegmt.selectedSegmentIndex == 1
            {
                userage = "Child"
            }else
            {
                userage = "Baby"
            }
            var attend = "attend"
            if attendSegmt.selectedSegmentIndex == 0
            {
                attend = "attend"
            }
            else if attendSegmt.selectedSegmentIndex == 1
            {
                attend = "Not Attending"
            }else
            {
                attend = "Cancel"
            }
            
            
            let params:[String:Any] =
                [
                    "email":userEmail,
                    "guest_id":guestId,
                    "first_name":firstNameTxt.text!,
                    "guest_email":emailTxt.text!,
                    "last_name":lastNameTxt.text!,
                    "group_id":self.pickerSelectedCatId,
                    "age_level":userage,
                    "attendence":attend,
                    "table_id":self.table_id,
                    "menu_id":self.menu_id,
                    "list_id":self.list_id,
                    "phone_number":phoneNumberTxt.text!,
                    "mobile_number":mobileNameTxt.text!,
                    "address":addressTxt.text!,
                    "city_town":cityTownTxt.text!,
                    "state":stateTxt.text!,
                    "zipcode":postalCodeTxt.text!,
                    "event_id":eventID,
                    "event_type":eventType,
                    "notes":notes.text!
            ]
            
            
            print(params)
            WebService.shared.apiDataPostMethod(url:addGuestURL, parameters: params) { (response, error) in
                if error == nil
                {
                    
                    if let resp = response as? NSDictionary
                    {
                        if let resp = resp.value(forKey: "message") as? String
                        {
                            if resp  == "successfully"
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
        
        func ALLCATEGORYAPI()
        {
            
            
            WebService.shared.apiDataGetMethod(url:GUESTGROUPNAME) { (response, error) in
                if error == nil
                {
                    
                    
                    if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                    {
                        
                        if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                        {
                            self.categoryList = data.mutableCopy() as! NSMutableArray
                            
//                            for i in 0..<self.categoryList.count
//                            {
//                                var dict = self.categoryList.object(at: i) as! NSDictionary
//                                var id = dict.value(forKey: "id") as! String
//                                if self.GuestDetails.value(forKey: "group_id") as! String == id
//                                {
//
//                                    self.groupInfomation.text = dict.value(forKey: "group_name") as! String
//                                    self.GroupIdNew = id
//                                    self.pickerSelectedValue = self.groupInfomation.text!
//
//                                }
//
//
//                            }
                            self.tableView.reloadData()
                            
                        }
                        self.categoryList = data.mutableCopy() as! NSMutableArray
                        self.pickerView.reloadAllComponents()
                    }
                    
                }
                else
                {
                    Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                    
                }
                
            }
        }
        
    }
    
    
    
    



