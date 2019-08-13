//
//  SuppliersPrice_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 24/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SuppliersPrice_VC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var greenImagesArray = [UIImage]()
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var serachTXT: UITextField!
    
    @IBOutlet weak var tableHegi: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myColor : UIColor = UIColor.lightGray
        serachTXT.layer.borderColor = myColor.cgColor
        serachTXT.layer.borderColor = myColor.cgColor
        serachTXT.layer.borderWidth = 1.0
        serachTXT.layer.cornerRadius = 5
        //tableview1.frame.size.height = tableview1.contentSize.height
        greenImagesArray = [UIImage(named:"image 3")!,UIImage(named: "image")!,UIImage(named: "image")!]
        tableHegi.constant = CGFloat((greenImagesArray.count * 378))
        self.tableview1.reloadData()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        return greenImagesArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupplierPriceTableViewCell") as! SupplierPriceTableViewCell
        
        cell.images.image = greenImagesArray[indexPath.row]
        cell.priceButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        cell.countLabel.layer.masksToBounds = true
        
        cell.countLabel.layer.cornerRadius = 5
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        //        if indexPath.row == 0
        //        {
        //            return 360
        //        }
        //
        //        if indexPath.row == 1
        //        {
        //            return 500
        //        }
        
        return 378
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClickHome_VC") as! ClickHome_VC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1
        {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClickHome_VC") as! ClickHome_VC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    @objc func checkMarkButtonClicked ( sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MessageVendor_VC") as! MessageVendor_VC
        vc.tittle = "yes"
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
