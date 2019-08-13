//
//  WeddingSuppliersViewController.swift
//  The-Truly-Scrumptious
//
//  Created by eWeb on 5/20/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD
import FloatRatingView

class WeddingSuppliersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate
{

    var CollectionDataArray = ["Catering","Venue","DJ","Wedding Cake","Favours & Gifts","Photography"]
    
    var MainArray = NSMutableArray()
    var CollectionImageArray = ["_0000_images","_0001_diEadh9sgT5d32yn2za8bj-768-80","_0002_Kelsey-and-Mike","_0003_s800","_0004_Tacoma+wedding+venues+stone+church","_0005_Catering"]
    var collectionCountData = ["1 request","3 request","4 request","1 request","1 request","2 request"]
    
    
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var view2: UIView!
    var viewHide1:String = ""
    var backHide:String = ""
    @IBOutlet var backButton: UIButton!
    @IBOutlet weak var searchViewLine: UIView!
    @IBOutlet weak var RequestViewLine: UIView!
    @IBOutlet weak var searchPopUpView: UIView!
    @IBOutlet weak var RequestPopUpView: UIView!
    @IBOutlet weak var MyTableView: UITableView!
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    
    
     var fromBack = ""
     var imageArray = ["Animals","Balloon","band","bar","beauty","Catering","Celebration","Childcare-service","Animals","Balloon","band","bar","beauty","Catering","Celebration","Childcare-service","bar","beauty","Catering","Celebration","Childcare-service","Animals","Balloon","band","bar","beauty","Catering","Celebration","Childcare-service"]
     var dataArray = ["Animals","Balloons","Band","Bar","Beautician","Catering","Celebrant","Childcare Service"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        searchViewLine.isHidden = false
        RequestViewLine.isHidden = true
        searchPopUpView.isHidden = false
        RequestPopUpView.isHidden = true
        
        MyCollectionView.register(UINib(nibName: "WeddingSupplierCollectionCell", bundle: nil), forCellWithReuseIdentifier: "WeddingSupplierCollectionCell")
        //SupplierWithCatApi()
        
        if viewHide1 == "yes"
        {
            self.view2.backgroundColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.headerLabel.textColor = UIColor.white
            self.reviewButton.isHidden = true
        }
        else{
            self.view2.backgroundColor = UIColor.white
            self.headerLabel.textColor = UIColor.init(red: 247/255, green: 182/255, blue: 139/255, alpha: 1)
            self.reviewButton.isHidden = false
        }
        
        
        if backHide == "yes"
        {
           self.backButton.isHidden = false
        }
        else
                {
            self.backButton.isHidden = true
        }
//        if fromBack == "yes"
//        {
//            self.backButton.isHidden = false
//            //  self.backBtn.isEnabled = false
//        }
//        else
//        {
//            self.backButton.isHidden = true
//            //self.backBtn.isEnabled = false
//        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SupplierWithCatApi()
    }
    
    @IBAction func reviewAction(_ sender: UIButton) {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "FindVenue_VC") as? FindVenue_VC
        self.navigationController?.pushViewController(view!, animated: true)
    }
    ////////////////////          TABLE VIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return MainArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeddingSupplierTableViewCell") as? WeddingSupplierTableViewCell
        
        let dict = self.MainArray.object(at: indexPath.row) as! NSDictionary
        
        cell?.dataLabel.text = dict.value(forKey: "supplier_category") as! String
        
        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
        
        
        return cell!
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
//
        
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "NewCatSupplierViewController") as? NewCatSupplierViewController
      
        var dict = self.MainArray.object(at: indexPath.row) as! NSDictionary
        
        if let suppliersArray = dict.value(forKey: "suppliers") as? NSArray
        {
            view?.FilterArray = suppliersArray
        }
       
        self.navigationController?.pushViewController(view!, animated: true)
        
    }
    
    ////////////////////          COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return CollectionDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeddingSupplierCollectionCell", for: indexPath) as? WeddingSupplierCollectionCell
        cell?.CollectionDataLabel.text = CollectionDataArray[indexPath.row]
        cell?.CollectionCountDataLbl.text = collectionCountData[indexPath.row]
        cell?.CollectionImg.image = UIImage(named: CollectionImageArray[indexPath.row])
        
        
        return cell!
    }
    
    
    ////////////////////          BUTTONS ACTION
    
    
    @IBAction func SearchBtnAct(_ sender: UIButton)
    {
        
        searchViewLine.isHidden = false
        searchPopUpView.isHidden = false
        RequestViewLine.isHidden = true
        RequestPopUpView.isHidden = true
        
    }
    @IBAction func RequestBtnAct(_ sender: UIButton)
    {
        
        searchViewLine.isHidden = true
        searchPopUpView.isHidden = true
        RequestViewLine.isHidden = false
        RequestPopUpView.isHidden = false
        
    }
    
    
    func SupplierWithCatApi()
    {
        SVProgressHUD.show()
        
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
        
        
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:SUPLLIERWITHCAT, parameters: params) { (response, error) in
            if error == nil
            {
            
                SVProgressHUD.dismiss()
                
                if let dict = response as? NSDictionary
                {
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.MainArray = dataDict.mutableCopy() as! NSMutableArray
                      
                        if self.MainArray.count == 0
                        {
                           // self.notFoundLbl.isHidden = false
                        }
                        else
                            
                        {
                            //self.notFoundLbl.isHidden = true
                        }
                    }
                    
                }
                self.MyTableView.reloadData()
            }
                
                
            else
            {
                SVProgressHUD.dismiss()
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }

  
}     //    Class Close

extension WeddingSuppliersViewController :UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
     
        
        let cellWidth : CGFloat = UIScreen.main.bounds.width / 2.0
        let cellheight = (UIScreen.main.bounds.height-110)  / 3.0
        
        return CGSize(width: cellWidth-30, height: cellheight)
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

