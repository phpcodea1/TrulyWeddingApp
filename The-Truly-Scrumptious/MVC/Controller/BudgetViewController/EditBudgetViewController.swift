//
//  EditBudgetViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 16/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class EditBudgetViewController: UIViewController
{
    var fromBack = ""
    var EditBudgetAmount = ""
    @IBOutlet var budgetAmount: UITextField!
    @IBOutlet var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if fromBack == "yes"
//        {
//            self.backBtn.isHidden = false
//          //  self.backBtn.isEnabled = false
//        }
//        else
//        {
//           self.backBtn.isHidden = true
//            //self.backBtn.isEnabled = false
//        }
        
        // Do any additional setup after loading the view.
        
        self.budgetAmount.text = EditBudgetAmount
    }
    

    @IBAction func goBack(_ sender: UIButton)
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
        
       //  NotificationCenter.default.post(name: Notification.Name("DidSelectCollection"), object: self)
        
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func saveBudget(_ sender: UIButton)
    {
        
        if (budgetAmount.text?.count == 0)
            
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Enter Budget")
        }
            
        else
        {
            if CheckInternet.Connection()
            {
                self.ADDBUDGETAPI()
            }
                
                
            else{
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please Check The Internet Connection")
            }
        }
        
        
    }

    func ADDBUDGETAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        var eventType = "celebaration"
        var eventID = "1"
        if let eventType1 = DEFAULT.value(forKey: "eventType") as? String
        {
            eventType = eventType1
        }
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "event_id":eventID,
                "event_type":eventType,
                "budget":budgetAmount.text!
                
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:ADDBUDGET, parameters: params) { (response, error) in
            if error == nil
            {
                
            
               
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSDictionary
                {
                    print("Budget data = \(data)")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "BudgetVC") as! BudgetVC
                    vc.budgetAmount = self.budgetAmount.text!
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
}
//
//extension Double {
//
//    /// Formats the receiver as a currency string using the specified three digit currencyCode. Currency codes are based on the ISO 4217 standard.
//    func formatAsCurrency(currencyCode: String) -> String? {
//        let currencyFormatter = NumberFormatter()
//        currencyFormatter.numberStyle = NumberFormatter.Style.CurrencyStyle
//        currencyFormatter.currencyCode = currencyCode
//        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
//        return currencyFormatter.stringFromNumber(NSNumber(self))
//    }
//}
