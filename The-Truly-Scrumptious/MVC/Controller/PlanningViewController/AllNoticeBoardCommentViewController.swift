//
//  AllNoticeBoardCommentViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 19/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import IQKeyboardManager

class AllNoticeBoardCommentViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {
    @IBOutlet weak var buttomConst: NSLayoutConstraint!
    
    @IBOutlet weak var buttomView: UIView!
    @IBOutlet weak var heightConst: NSLayoutConstraint!
    @IBOutlet weak var replyText: UITextView!
    @IBOutlet var noticeTable: UITableView!
    var noticeDataArray = NSArray()
     var noticeDataDict = NSDictionary()
    var noticeID = ""
     var comment_id = ""
    var notice_comments = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            self.DetailsAPI()
        }
        
        
        noticeTable.delegate = self
        noticeTable.dataSource = self
        
        
      noticeTable.backgroundColor = UIColor.clear
        noticeTable.sectionHeaderHeight = UITableView.automaticDimension
        
        noticeTable.rowHeight = UITableView.automaticDimension
        IQKeyboardManager.shared().isEnabled = false
        self.noticeTable.estimatedSectionHeaderHeight = 300
        self.noticeTable.rowHeight = 75
        // Do any additional setup after loading the view.
        
        buttomView.layer.backgroundColor = UIColor.clear.cgColor
       // buttomView.layer.borderWidth = 1
        
        replyText.layer.backgroundColor = UIColor.white.cgColor
        replyText.layer.borderWidth = 1
        replyText.layer.cornerRadius =  5
        replyText.clipsToBounds = true
        
        replyText.delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
       IQKeyboardManager.shared().isEnabled = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    @objc func keyboardWillShow(_ notification: Notification)
    {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            print(keyboardHeight)
         
            self.buttomConst.constant = keyboardHeight + 5
        }
    }
    @objc func keyboardWillHide(_ notification: Notification)
    {

            self.heightConst.constant = 60
            self.buttomConst.constant = 0
        
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        let count = textView.text.count
        if count > 50
        {
            self.heightConst.constant = 150
        }
        return true
        
    }
    func textViewDidEndEditing(_ textView: UITextView)
    {
        let count = textView.text.count
        if count > 50
        {
            self.heightConst.constant = 150
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        
        return 1
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
       
    return  notice_comments.count
        
//        if let notice_comments = self.noticeDataDict.value(forKey: "notice_comments") as? NSArray
//        {
//            return  notice_comments.count
//        }
//          else
//        {
//            return 0
//
//        }
        
       

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("NoticeTableViewCell", owner: self, options: nil)?.first as! NoticeTableViewCell
        
        cell.leftConst.constant = 32
        
        cell.removeBtn.tag = indexPath.row
        
        cell.removeBtn.addTarget(self, action: #selector(removeComment), for: .touchUpInside)
        cell.backgroundColor = UIColor.clear
        
        cell.profileImg.layer.cornerRadius =  cell.profileImg.frame.height/2
        cell.profileImg.clipsToBounds = true
        
//        if let notice_comments = self.noticeDataDict.value(forKey: "notice_comments") as? NSArray
//        {
//
//        self.notice_comments = notice_comments
//
        var dict = self.notice_comments.object(at: indexPath.row) as! NSDictionary

            if let title = dict.value(forKey: "username") as? String
            {
                cell.title.text = title
                
            }
            
            if let reply_profileimg = dict.value(forKey: "reply_profileimg") as? String
            {
                if reply_profileimg == ""
                {
                    cell.profileImg.image = UIImage(named: "image-1")
                }
                else
                {
                    let img = URL(string: reply_profileimg)
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
        
        if let description = dict.value(forKey: "comment") as? String
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
        else
        {
            cell.removeBtn.isHidden = true
        }
        
        //}
        return cell
        
    }

    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            let cell = Bundle.main.loadNibNamed("NoticeTableViewCell", owner: self, options: nil)?.first as! NoticeTableViewCell
            
        var dict = self.noticeDataDict
        cell.profileImg.layer.cornerRadius =  cell.profileImg.frame.height/2
        cell.profileImg.clipsToBounds = true
        
        cell.removeBtn.isHidden = true
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
            return cell
        
       
        
        
    }
   
   
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    @IBAction func sendComment(_ sender: UIButton)
    {
        if  (replyText.text?.count == 0)
        {
            Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr: "Please add reply message.")
        }
        else
        {
            
            if !(NetworkEngine.networkEngineObj.isInternetAvailable())
            {
                NetworkEngine.networkEngineObj.showInterNetAlert()
            }
            else
            {
                
               self.AddReplyAPI()
            }
        }
    }
    
    
    func AddReplyAPI()
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
            "email":userEmail,
            "comment":replyText.text!,
            "notice_id":self.noticeID
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:REPLYNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let dict = response as? NSDictionary
                {
                    if let status = (dict.value(forKey: "status")) as? String
                    {
                        if status == "success"
                        {
                            self.replyText.text = ""
                            let count = self.replyText.text.count
                            if count < 50
                            {
                                self.heightConst.constant = 50
                            }
                             self.DetailsAPI()
                            //self.navigationController?.popViewController(animated: true)
                        }
                     
                    }
                    
                }
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
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
                var dict = self.notice_comments.object(at: sender.tag) as! NSDictionary
                
                if let id = dict.value(forKey: "id") as? String
                {
                  
                    self.comment_id = id
                }
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
                "comment_id":self.comment_id
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DELETECOMMENTNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                self.DetailsAPI()
            }
            else
            {
                Helper.helper.showAlertMessage(vc: self, titleStr: "Notification", messageStr:"Error")
                
            }
            
        }
    }
    func DetailsAPI()
    {
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        
        
        let params:[String:Any] =
            [
                "email":userEmail,
                "notice_board_id":self.noticeID]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DEATILSCOMMENTNOTICEBOARD, parameters: params) { (response, error) in
            if error == nil
            {
                
                                if let postData = (response as! NSDictionary).value(forKey: "postData") as? NSArray
                                {
                                    if postData.count>0
                                    {
                                        if let notice_comment = postData.object(at: 0) as? NSDictionary
                                        {
                                            if let dict = notice_comment.value(forKey: "notice_comments") as? NSArray
                                            {
                                                self.notice_comments = dict
                                            }
                                        }
                                    }
                                    
                                    
                                   
                
                
                
                                    self.noticeTable.reloadData()
                
                                }
                
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
