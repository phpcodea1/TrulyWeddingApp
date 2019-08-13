//
//  WeddingShowViewController.swift
//  TrulyApp
//
//  Created by eWeb on 5/16/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class WeddingShowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var weddingShowArray = NSMutableArray()
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "AllWeddingShowTableViewCell", bundle: nil), forCellReuseIdentifier: "AllWeddingShowTableViewCell")
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
             WediingShowAPI()
        }
       
    
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return weddingShowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "AllWeddingShowTableViewCell") as? AllWeddingShowTableViewCell
         var dict = self.weddingShowArray.object(at: indexPath.section) as! NSDictionary
        if let title = dict.value(forKey: "title") as? String
        {
            cell?.weddingTitle.text = title
        }
        if let location = dict.value(forKey: "location") as? String
        {
            cell?.venueLbl.text = location
        }
        
        if let location = dict.value(forKey: "location") as? String
        {
            cell?.venueLbl.text = location
        }
        
        if let date = dict.value(forKey: "date") as? String
        {
            cell?.dateLbl.text = self.convertDateFormater(date)
        }
        if let image = dict.value(forKey: "image") as? String
        {
           if  let url = URL(string: image) as? URL
           {
             cell?.profileImg.sd_setImage(with: url, completed: nil)
            }
        }
        
        cell?.infoButton.tag = indexPath.row
        cell?.infoButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
        cell?.preRegisterBtn.tag = indexPath.row
       cell?.preRegisterBtn.addTarget(self, action: #selector(preRegisterBtnClicked(sender:)), for: .touchUpInside)
        
        return cell!
        
    }
    
    @objc func preRegisterBtnClicked ( sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PreRegisterWeddingViewController") as! PreRegisterWeddingViewController
         var dict = self.weddingShowArray.object(at: sender.tag) as! NSDictionary
        if let title = dict.value(forKey: "id") as? String
        {
            vc.SHOWID = title
        }
        
        vc.ShowData = dict
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func checkMarkButtonClicked ( sender: UIButton)
    {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WeddingShowDetails_VC") as! WeddingShowDetails_VC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
 
    @IBAction func BackAct(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func WediingShowAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail
                ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:WEDDINGSHOW, parameters: params) { (response, error) in
            if error == nil
            {
               
                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                {
                    self.weddingShowArray = data.mutableCopy() as! NSMutableArray
                    
                }
                self.tableView.reloadData()
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
    
    
}
