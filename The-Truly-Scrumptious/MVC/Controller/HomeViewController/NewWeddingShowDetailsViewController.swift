//
//  NewWeddingShowDetailsViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NewWeddingShowDetailsViewController: UIViewController {
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var descText: UITextView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titleLble: UILabel!
    
    var id = ""
    
    var DataDict = NSDictionary()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            self.WeddingShowDetailAPI()
            
        }
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func preregisterAct(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreRegisterWeddingViewController") as! PreRegisterWeddingViewController
        
        if let title = self.DataDict.value(forKey: "id") as? String
        {
            vc.SHOWID = title
        }
        
        vc.ShowData = self.DataDict
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func WeddingShowDetailAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "id":self.id
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DETAILSWEDDINGSHOW, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSDictionary
                {
                    self.DataDict = data
             
                    if let name = self.DataDict.value(forKey: "title") as? String
                    {
                        self.titleLble.text = name
                    }
                    if let date = self.DataDict.value(forKey: "date") as? String
                    {
                        self.dateLbl.text = "Date :" + date
                    }
                    if let time = self.DataDict.value(forKey: "time") as? String
                    {
                        self.timeLbl.text = "Time:  "+time
                    }
                    if let location = self.DataDict.value(forKey: "location") as? String
                    {
                        self.addressLbl.text = location
                    }
                    if let description = self.DataDict.value(forKey: "description") as? String
                    {
                        self.descText.text = description
                    }
                    if let image = self.DataDict.value(forKey: "image") as? String
                    {
                        if image != ""
                        {
                            let url = URL(string: image)
                            DispatchQueue.main.async {
                                
                                self.bannerImg.sd_setImage(with: url, completed: nil)
                            }
                        }
                       
                    }
                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Time out")
                
            }
            
        }
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
