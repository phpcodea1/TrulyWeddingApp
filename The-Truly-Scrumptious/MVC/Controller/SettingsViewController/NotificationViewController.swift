//
//  NotificationViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 30/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    var MainArray = NSMutableArray()
    var mainDict = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        // Do any additional setup after loading the view.
        self.nodataLbl.isHidden = true
        if let reviewsAray =  self.mainDict.value(forKey: "reviews") as? NSArray
        {
            if reviewsAray.count>0
            {
                self.nodataLbl.isHidden = true
            }
            else
            {
                self.nodataLbl.isHidden = false
            }
            
            
        }
        else
        {
            self.nodataLbl.isHidden = false
            
        }
        //AllRequestAPI()
    }
    
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let reviewsAray =  self.mainDict.value(forKey: "reviews") as? NSArray
        {
            
            return  reviewsAray.count
        }
        else
        {
            
            return  0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell") as! RatingTableViewCell
        
        cell.backgroundColor = UIColor.clear
        
        cell.backgroundView?.backgroundColor = UIColor.clear
        cell.backView.backgroundColor = UIColor.clear
        if let reviewsAray =  self.mainDict.value(forKey: "reviews") as? NSArray
        {
            
            if let reviewsDict = reviewsAray.object(at: indexPath.row) as? NSDictionary
            {
                if let customer_name = reviewsDict.value(forKey: "customer_name") as? String
                {
                    
                    cell.userName.text = customer_name
                    
                }
                if let review_text = reviewsDict.value(forKey: "review_text") as? String
                {
                    
                    cell.reviewTxt.text = review_text
                    
                }
                if let average_rating = reviewsDict.value(forKey: "average_rating") as? Int
                {
                    
                    cell.rating.rating = Float(average_rating)
                    
                }
                if let created_at = reviewsDict.value(forKey: "created_at") as? String
                {
                    
                    cell.timeLbl.text = convertDateFormater(created_at)
                    
                }
                
            }
            
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewPhotosViewController") as! NewPhotosViewController
        //        var dict = self.MainArray.object(at: indexPath.row) as!NSDictionary
        //
        //        if let id1 = dict.value(forKey: "id") as? String
        //        {
        //            vc.id = id1
        //        }
        //        self.navigationController?.pushViewController(vc, animated: true)
        //
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        // 2019-08-01 05:00:00
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
}
