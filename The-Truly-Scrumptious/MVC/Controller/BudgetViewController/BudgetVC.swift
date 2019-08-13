//
//  BudgetVC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SVProgressHUD
import SDWebImage

 class BudgetVC:UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var nameArray = [String]()

 var budgetAmount = ""
    
    
    @IBOutlet var costLbl: UILabel!
    
    var activeEventId = ""
    var activeEventType = ""
    
    var mainArray = NSMutableArray()
    var subArray = NSMutableArray()
    
    
    @IBOutlet weak var budgetTable: UITableView!
    
    var titleArray = ["Band","Beauty and health","Cake","Catering","Ceremony Music","DJ","Favour and Gifts","Photography","Ballons","Bar","Childcare Service"]
     var imageArray = ["Accessories","Bridalwear","Cake","Catering","Ceremony-music","clothes","decor-icon","Entertainment","Favors","Gift-1","Jewellery","Menswear","photography","stationery -icon","Transport","location","videography"]
    var selectedIndex = Int()
    var selectedSection = Int()
    var selectedProfession1 = String()
    var selectedProfession = String()
    
    var arrayData = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetTable.delegate = self
        budgetTable.dataSource = self
        self.budgetTable.sectionHeaderHeight = UITableView.automaticDimension
        self.budgetTable.estimatedSectionHeaderHeight = 75
       

        costLbl.text = "£ " + budgetAmount
        
        budgetTable.rowHeight = UITableView.automaticDimension
        self.budgetTable.rowHeight = 75
        selectedSection = -1
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        selectedSection = -1
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
             ALLBUDGETCATAPI()
        }
      
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainArray.count
    }
   
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print("selcted section \(selectedSection)")
            if selectedSection != -1
            {
                if selectedSection == section
                {
                    return  self.subArray.count + 1
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
  
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> CGFloat?
    {
        return 250
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        var dict = self.mainArray.object(at: indexPath.section) as! NSDictionary

        
        if let subData = dict.value(forKey: "expense") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        
       
        
        if indexPath.row < self.subArray.count
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ExpenseViewController") as! ExpenseViewController
            vc.expenseData = self.subArray.object(at: indexPath.row) as! NSDictionary
            vc.catName2 = dict.value(forKey: "category_name") as! String
            vc.pickerSelectedValue = dict.value(forKey: "category_name") as! String
             vc.catId2 = dict.value(forKey: "id") as! String
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
        else
        {
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewExpense_VC") as! NewExpense_VC
            vc.catName2 = dict.value(forKey: "category_name") as! String
            vc.catId2 = dict.value(forKey: "id") as! String
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row ==  self.subArray.count
        {
            return 60
        }
        else
        {
          return 80
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        
        print("self.subArray.count = \(self.subArray.count)")
        print("indexPath.row = \(indexPath.row)")
        
        if indexPath.row < self.subArray.count
        {
            let cell = Bundle.main.loadNibNamed("budgetRowCellTableViewCell", owner: self, options: nil)?.first as! budgetRowCellTableViewCell
            var dict = self.subArray.object(at: indexPath.row) as! NSDictionary
            cell.costLbl.text = "Cost : " + " £ " + "\(dict.value(forKey: "amount") as! String)"
            cell.title.text = "\(dict.value(forKey: "expense_name") as! String)"
            
//            if indexPath.row == 1
//            {
//               // cell.topLineView.isHidden = true
//
//            }
//            else if indexPath.row == self.subArray.count
//            {
//                let cell1 = Bundle.main.loadNibNamed("NewExpenseTableViewCell", owner: self, options: nil)?.first as! NewExpenseTableViewCell
//
//                return cell1
//            }
//            else
//
//            {
//
//                //cell.topLineView.isHidden = false
//            }
            return cell
        }
        else
        {
            let cell1 = Bundle.main.loadNibNamed("NewExpenseTableViewCell", owner: self, options: nil)?.first as! NewExpenseTableViewCell
            
            return cell1
        }
        
//        if indexPath.row == 1
//        {
//            cell.topLineView.isHidden = true
//
//        }
//        else if indexPath.row == self.subArray.count
//        {
//            let cell1 = Bundle.main.loadNibNamed("NewExpenseTableViewCell", owner: self, options: nil)?.first as! NewExpenseTableViewCell
//
//             return cell1
//        }
//        else
//
//        {
//
//            cell.topLineView.isHidden = false
//        }
        
   
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
       
        
        let headercell = Bundle.main.loadNibNamed("NewBudgetCellTableViewCell", owner: self, options: nil)?.first as! NewBudgetCellTableViewCell
        

               var dict = self.mainArray.object(at: section) as! NSDictionary
                headercell.title.text = dict.value(forKey: "category_name") as! String
//                if self.subArray.count>0
//                {
//                    self.subArray.removeAllObjects()
//                }
//
        
//        if let subData = dict.value(forKey: "expense") as? NSArray
//        {
//            self.subArray = subData.mutableCopy() as! NSMutableArray
//
//        }
        if section < imageArray.count
        {
           headercell.imageIcon.image = UIImage(named: imageArray[section])
        }
        else
        {
           headercell.imageIcon.image = UIImage(named: imageArray[0])
        }
        
        headercell.arrowBtn2.tag = section
        
        headercell.arrowBtn2.addTarget(self, action: #selector(arrowClick2), for: .touchUpInside)
        
        headercell.arrowBtn.tag = section
       
        headercell.arrowBtn.addTarget(self, action: #selector(arrowClick), for: .touchUpInside)
        
        if  selectedSection == section
        {
             headercell.arrowBtn.setImage(UIImage(named: "Up-icon"), for: .normal)
            headercell.lineView.isHidden = true
 
        }
        else
        {
              headercell.arrowBtn.setImage(UIImage(named: "dropdown-errow"), for: .normal)
            headercell.lineView.isHidden = false
        }
        
        return headercell
    }
    
    
   
    @IBAction func goBack(_ sender: UIButton) {
        
       // self.navigationController?.popViewController(animated: true)
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        let navVC = UINavigationController.init(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        if let window = UIApplication.shared.windows.first
        {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
        
    }
    @objc func arrowClick(_ sender:UIButton)
    {
        var dict = self.mainArray.object(at: sender.tag) as! NSDictionary
    
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        if let subData = dict.value(forKey: "expense") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        if selectedSection == sender.tag
        {
            selectedSection = -1
        }
        else
        {
           selectedSection = sender.tag
        }

        budgetTable.reloadData()
    }
    @objc func arrowClick2(_ sender:UIButton)
    {
        var dict = self.mainArray.object(at: sender.tag) as! NSDictionary
        if self.subArray.count>0
        {
            self.subArray.removeAllObjects()
        }
        
        
        if let subData = dict.value(forKey: "expense") as? NSArray
        {
            self.subArray = subData.mutableCopy() as! NSMutableArray
            
        }
        if selectedSection == sender.tag
        {
            selectedSection = -1
        }
        else
        {
            selectedSection = sender.tag
        }
        
        budgetTable.reloadData()
    }
    
    @IBAction func AddButton(_ sender: UIButton)
    {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditBudgetViewController") as! EditBudgetViewController
        vc.EditBudgetAmount = budgetAmount
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func ALLBUDGETCATAPI()
    {
        SVProgressHUD.show()
        SVProgressHUD.setBorderColor(UIColor.white)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.black)
        
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
        
//        let params:[String:Any] = [
//            "email":"tester757411@gmail.com",
//            "event_id":"9",
//            "event_type":"celebration"
//        ]
//
        
        print(params)
        print("para in save = \(params)")
        Alamofire.request(ALLBUDGETCAT, method: .post, parameters: params, encoding: URLEncoding.httpBody).responseString
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
                                        var mainArray = data.mutableCopy() as! NSMutableArray
                                        
                                        
                                        self.mainArray = ((data as NSArray).sortedArray(using: [NSSortDescriptor(key: "category_name", ascending: true)]) as! NSArray).mutableCopy() as! NSMutableArray
                                        
                                    }
                                   
                                    
                                    
                                    
                                   // self.mainArray = (self.mainArray.reversed() as! NSArray).mutableCopy() as! NSMutableArray
                                    
                                    print("mainArray count \(self.mainArray.count)")
                                    
                                }
                                self.budgetTable.reloadData()
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
   
    
}
