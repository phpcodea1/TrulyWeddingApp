//
//  MYNoticeBoardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class MYNoticeBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet var noticeTable: UITableView!
    var noticeDataArray = NSArray()
    
    var comment_id = ""
   var noticeboard_Id  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTable.delegate = self
        noticeTable.dataSource = self
        self.nodataLbl.isHidden = true
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
           self.AllNoticeBoardAPI()
        }
        
        
        
        noticeTable.rowHeight = UITableView.automaticDimension
        self.noticeTable.rowHeight = 75
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            self.AllNoticeBoardAPI()
        }
        
    }

    @IBAction func noticeboardAction(_ sender: UIButton) {
       
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddDescNoticeBoardViewController") as! AddDescNoticeBoardViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewAddNewNoticeBoardViewController") as! NewAddNewNoticeBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return self.noticeDataArray.count
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120 //UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("NoticeTableViewCell", owner: self, options: nil)?.first as! NoticeTableViewCell
        
        var dict = self.noticeDataArray.object(at: indexPath.row) as! NSDictionary
        
        cell.profileImg.layer.cornerRadius =  cell.profileImg.frame.height/2
        cell.profileImg.clipsToBounds = true
      
        cell.removeBtn.tag = indexPath.row
        
        cell.removeBtn.addTarget(self, action: #selector(removeComment), for: .touchUpInside)

        if let post_profileimg = dict.value(forKey: "post_profileimg") as? String
        {
            if post_profileimg == ""
            {
                cell.profileImg.image = UIImage(named: "image-1")
            }
            else
            {
                let img = URL(string: post_profileimg)
                cell.profileImg.sd_setImage(with: img, placeholderImage: nil)
            }
        }
        else
        {
            cell.profileImg.image = UIImage(named: "image-1")
        }
        
        
        if let date = dict.value(forKey: "created_at") as? String
        {
            cell.datelbl.text = self.convertDateFormater(date)
            
        }
        if let title = dict.value(forKey: "title") as? String
        {
            cell.title.text = title
            
        }
        if let description = dict.value(forKey: "description") as? String
        {
            cell.commentTxt.text = description
            
        }
        var userEmail1 = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail1 = email
        }
        if let user_email2 = dict.value(forKey: "user_email") as? String
        {
            
            if userEmail1 == user_email2
            {
                cell.removeBtn.isHidden = false
            }
            else
            {
               cell.removeBtn.isHidden = true
            }
        }
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = Bundle.main.loadNibNamed("NoticeTableViewCell", owner: self, options: nil)?.first as! NoticeTableViewCell
        
               cell.backgroundColor = UIColor.white
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllNoticeBoardCommentViewController") as! AllNoticeBoardCommentViewController
        var dict = self.noticeDataArray.object(at: indexPath.row) as!NSDictionary
        if let id = dict.value(forKey: "id") as? String
        {
            vc.noticeID = id
            
        }
        
            vc.noticeDataDict = dict
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
 
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func removeComment(_ sender:UIButton)
    {
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
                var dict = self.noticeDataArray.object(at: sender.tag) as! NSDictionary
                
                if let id = dict.value(forKey: "id") as? String
                {
                    
                    self.noticeboard_Id = id
                }
                self.DeleteNoticeBoardAPI()
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

    
    
    func AllNoticeBoardAPI()
    {
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
            "email":userEmail
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:GETNOTICEWITHCOMMNET, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let dict = response as? NSDictionary
                {
                
                    if let dataDict = (dict.value(forKey: "data")) as? NSArray
                    {

                    var noticeDataArray = (dataDict.reversed() as! NSArray)
                        
                        self.noticeDataArray = noticeDataArray
                        
                    }
                    if self.noticeDataArray.count>0
                    {
                        self.nodataLbl.isHidden = true
                    }
                    else
                        
                    {
                        self.nodataLbl.isHidden = false
                    }

                }
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            self.noticeTable.reloadData()
            
        }
        
    }
    func DeleteNoticeBoardAPI()
    {
        var eventType = "celebaration"
        var eventID = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
      
        
        let params:[String:Any] = [
            "email":userEmail,
            "noticeboard_Id":self.noticeboard_Id
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETENOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                self.AllNoticeBoardAPI()
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            self.noticeTable.reloadData()
            
        }
        
    }
    
    
    @objc func removeComment2(_ sender:UIButton)
{
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
    self.DeleteCommentAPI()
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
    
    func DeleteCommentAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "comment_id":self.comment_id]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETECOMMENTNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
               
                //                if let data = (response as! NSDictionary).value(forKey: "data") as? NSArray
                //                {
                //                    self.GuestListArray = data.mutableCopy() as! NSMutableArray
                //
                //
                //
                //                    self.GuestListTable.reloadData()
                //
                //                }
                
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    
    
    func convertDateFormater(_ date: String) -> String
    {
        //"2019-08-19 15:19:26",
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }

}
