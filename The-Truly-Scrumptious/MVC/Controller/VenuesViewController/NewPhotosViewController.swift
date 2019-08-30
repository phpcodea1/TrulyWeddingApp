//
//  NewPhotosViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 01/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import ObjectMapper
import AVKit
import AVFoundation
import FloatRatingView
import MessageUI
import Messages

class NewPhotosViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var selectedSection2 = Int()
    var selectedSection3 = Int()
    var selectedSection = Int()
    var selectedRow = Int()
  
    var likeStatus = ""
    var LikeId = ""
    
    
    var emailToSend = ""
    var callToSend = ""
    var BookStatus = ""
    var sortStatus = ""
    
    var fromBookMark = ""
    
    @IBOutlet weak var headerLbl: UILabel!
    

    var  amenitiesArray = ["Bedrooms","External catering permit","Cultural specialist","Evening reception capacity","Exclusive use","Firework permit","Golf resort","Landscape ground","Marquee on site","Civil license","Pet allowed","Onsite parking","Seated reception capacity","Party room capacity","Package bridal suite","Spa resort","Swiming facilities","Venue hire only","Marquee permit"]
    
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableview1: UITableView!
    
    var DetailModel:VenueDetailsModel!
    
    
    @IBOutlet weak var tableView: UITableView!
    var nameArray = [String]()
    var mainDict = NSDictionary()
    
    
    @IBOutlet weak var headerView1: UIView!
    var id = ""
    var login_id = ""
    var playerviewcontroller = AVPlayerViewController()
    var playerview = AVPlayer ()
   
    var playerViewController=AVPlayerViewController()
    
    var playerView = AVPlayer()
    var arrayOverView = ["    Venue Type","    Evening Capacity","    Seating Capacity","    Bedrooms","    Sleeps","    Awards","    Insurance ","    Qualifications","    Professional Membership"]
    
    var arrayHeader = ["","Full Descrption","Overview","Reviews","Photos","Amenities"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
  
        
        
        self.nameArray = ["External Catering Permitted","Evening Reception Capacity","Civil Licence","Fireworks Permitted"]
        selectedSection = -1
        
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "PhotoHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoHeaderTableViewCell")
        
        tableView.register(UINib(nibName: "OverViewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverViewTableViewCell")
        
        tableView.register(UINib(nibName: "FullDescTableViewCell", bundle: nil), forCellReuseIdentifier: "FullDescTableViewCell")
        
        
         tableView.register(UINib(nibName: "PhotoButtomHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoButtomHeaderTableViewCell")
        tableView.register(UINib(nibName: "AmintiesTableViewCell", bundle: nil), forCellReuseIdentifier: "AmintiesTableViewCell")
        
           tableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: "MediaTableViewCell")
    tableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingTableViewCell")
        
    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
         tableView.register(UINib(nibName: "PhotoFirstSectTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoFirstSectTableViewCell")
        
        tableView.backgroundColor = UIColor.white
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
            
            self.detailApi()
        }
        
    }
    @objc func methodOfReceivedNotification(notification: Notification)
    {
       var data = DEFAULT.value(forKey: "media_file") as! String


        let url = URL(string: data)!
    
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        
        if selectedSection != -1
        {
            if selectedSection == section
            {
                if section == 0
                {
                    return 1
                }
                else if section == 1
                {
                    return 1
                }
                else if section == 2
                {
                    return self.arrayOverView.count
                }
                else if section == 3
                {
                    
                                        var count = 1
                                        if let reviews =  self.mainDict.value(forKey: "reviews") as? NSArray
                                        {
                                            if reviews.count>0
                                            {
                                                count =  reviews.count
                                            }
                                            
                                        }
                    
                    
                    return count
                }
                else if section == 4
                {
                    return 1
                }

                else if section == 5
                {
//                    var count = 0
//                    if let amenitiesAray =  self.mainDict.value(forKey: "amenities") as? NSArray
//                    {
//
//                        if amenitiesAray.count>0
//                        {
//                            if let amentiDict = amenitiesAray.object(at: 0) as? NSDictionary
//                            {
//                               count =  amentiDict.allValues.count
//                            }
//                        }
//                    }
                    
                    return amenitiesArray.count
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
        else
        {
            return 0
        }
        
        
        
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section  == 0
        {
            
        }
       else if indexPath.section  == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FullDescTableViewCell") as! FullDescTableViewCell
            if let desc = self.DetailModel.data?.descriptionField
            {
                cell.descLbl.text = desc
            }
            
           
        return cell
        }
        else if indexPath.section == 2
        {
              let cell = tableView.dequeueReusableCell(withIdentifier: "OverViewTableViewCell") as! OverViewTableViewCell
            cell.overLbl1.text = arrayOverView[indexPath.row]
            if indexPath.row == 0
            {
                if let cat_name = self.mainDict.value(forKey: "cat_name") as? String
                {
                    
                     cell.overLbl2.text = cat_name
                    
//                    if type.lowercased() == "v"
//                    {
//                        cell.overLbl2.text = "Venue"
//                    }
//                    else
//                    {
//                        cell.overLbl2.text = "Supplier"
//                    }
                    
                }
            }
           else if indexPath.row == 1
            {
                if let evening_capacity = self.mainDict.value(forKey: "evening_capacity") as? String
                {
    
                        cell.overLbl2.text = evening_capacity
                    
                    
                }
            }
            else if indexPath.row == 2
            {
                if let guest = self.mainDict.value(forKey: "guest") as? String
                {
                    
                    cell.overLbl2.text = guest
                    
                    
                }
            }
            else if indexPath.row == 3
            {
                if let bedrooms = self.mainDict.value(forKey: "room") as? String
                {
                    
                    cell.overLbl2.text = bedrooms
                    
                    
                }
            }
            else if indexPath.row == 4
            {
                if let sleep_room = self.mainDict.value(forKey: "sleep_room") as? String
                {
                    
                    cell.overLbl2.text = sleep_room
                    
                    
                }
            }
            else if indexPath.row == 5
            {
                if let awards = self.mainDict.value(forKey: "awards") as? String
                {
                    
                    cell.overLbl2.text = awards
                    
                    
                }
            }
            else if indexPath.row == 6
            {
                if let insurance = self.mainDict.value(forKey: "insurance") as? String
                {
                    
                    cell.overLbl2.text = insurance
                    
                    
                }
            }
            else if indexPath.row == 7
            {
                if let qualification = self.mainDict.value(forKey: "qualification") as? String
                {
                    
                    cell.overLbl2.text = qualification
                    
                    
                }
            }
            else if indexPath.row == 8
            {
                if let profssional_membership = self.mainDict.value(forKey: "profssional_membership") as? String
                {
                    
                    cell.overLbl2.text = profssional_membership
                    
                    
                }
            }
            return cell
        }
            
        else if indexPath.section == 3
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RatingTableViewCell") as! RatingTableViewCell
            
            if let reviewsAray =  self.mainDict.value(forKey: "reviews") as? NSArray
            {
                if reviewsAray.count>0
                {
                    cell.rating.isHidden = false
                    cell.timeLbl.isHidden = false
                    cell.userName.isHidden = false
                    cell.reviewTxt.isHidden = false
                    cell.noFound.isHidden = true
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
                        if let average_rating = reviewsDict.value(forKey: "average_rating") as? String
                        {
                            if average_rating != ""
                            {
                              cell.rating.rating = Float(average_rating)!
                            }
                            
                            
                        }
                        if let created_at = reviewsDict.value(forKey: "created_at") as? String
                        {
                            
                            cell.timeLbl.text = convertDateFormater(created_at)
                            
                        }
                        
                    }
                }
                else
                {
                    cell.rating.isHidden = true
                    cell.timeLbl.isHidden = true
                    cell.userName.isHidden = true
                    cell.reviewTxt.isHidden = true
                    
                   cell.noFound.isHidden = false
                }
            }
            
            return cell
        }
            
        else if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MediaTableViewCell") as! MediaTableViewCell
            if let media = self.mainDict.value(forKey: "media") as? NSArray
            {
                cell.load(array: media)
                if media.count>0
                {
                    cell.nofoundLbl.isHidden = true
                }
                else
                {
                   cell.nofoundLbl.isHidden = false
                }
            }
            
            
            cell.collectionView.reloadData()
            return cell
        }
        else if indexPath.section == 5
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AmintiesTableViewCell") as! AmintiesTableViewCell
          
           if let amenitiesAray =  self.mainDict.value(forKey: "amenities") as? NSArray
           {
             cell.amity1Lbl.text =  "\(amenitiesArray[indexPath.row])"
            
            if amenitiesAray.count>0
            {
                if let amentiDict = amenitiesAray.object(at: 0) as? NSDictionary
                    {
                    
                         if indexPath.row == 0
                        {
                            if let bedrooms = amentiDict.value(forKey: "bedrooms") as? String
                            {
                                
                                cell.amityLbl2.text = bedrooms
                            
                            }
                        }
                        else if indexPath.row == 1
                        {
                            if let external_catering_permit = amentiDict.value(forKey: "external_catering_permit") as? String
                            {
                                if external_catering_permit == "0"
                                {
                                  cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                }
                               
                            }
                        }
                         else if indexPath.row == 2
                         {
                            if let cultural_specialist = amentiDict.value(forKey: "cultural_specialist") as? String
                            {
                                
                                if cultural_specialist == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                }
                               
                            }
                        }
                         else if indexPath.row == 3
                         {
                            if let evening_reception_capacity = amentiDict.value(forKey: "evening_reception_capacity") as? String
                            {
                                
                                cell.amityLbl2.text = evening_reception_capacity
                            }
                        }
                        
                         else if indexPath.row == 4
                         {
                            if let exclusive_use = amentiDict.value(forKey: "exclusive_use") as? String
                            {
                                if exclusive_use == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                }
                                
                               
                            }
                         }
                         else if indexPath.row == 5
                         {
                            if let firework_permit = amentiDict.value(forKey: "firework_permit") as? String
                            {
                                if firework_permit == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                         }
                         else if indexPath.row == 6
                         {
                            if let golf_resort = amentiDict.value(forKey: "golf_resort") as? String
                            {
                                if golf_resort == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                               
                            }
                        }
                         else if indexPath.row == 7
                         {
                            if let landscape_ground = amentiDict.value(forKey: "landscape_ground") as? String
                            {
                                
                                if landscape_ground == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                         }
                         else if indexPath.row == 8
                         {
                            if let marquee_on_site = amentiDict.value(forKey: "marquee_on_site") as? String
                            {
                                
                                if marquee_on_site == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                         }
                         else if indexPath.row == 9
                         {
                            if let civil_license = amentiDict.value(forKey: "civil_license") as? String
                            {
                                
                                if civil_license == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                        }
                        
                        
                        
                        
                         else if indexPath.row == 10
                         {
                            if let pet_allowed = amentiDict.value(forKey: "pet_allowed") as? String
                            {
                                
                                if pet_allowed == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                         }
                         else if indexPath.row == 11
                         {
                            if let onsite_parking = amentiDict.value(forKey: "onsite_parking") as? String
                            {
                                
                                if onsite_parking == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                         }
                         else if indexPath.row == 12
                         {
                            if let seated_reception_capacity = amentiDict.value(forKey: "seated_reception_capacity") as? String
                            {
                                
                                cell.amityLbl2.text = seated_reception_capacity
                            }
                        }
                        
                        
                        
                        
                         else if indexPath.row == 13
                         {
                            if let party_room_capacity = amentiDict.value(forKey: "party_room_capacity") as? String
                            {
                                
                                cell.amityLbl2.text = party_room_capacity
                            }
                         }
                         else if indexPath.row == 14
                         {
                            if let package_bridal_suite = amentiDict.value(forKey: "package_bridal_suite") as? String
                            {
                                if package_bridal_suite == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            
                            }
                         }
                         else if indexPath.row == 15
                         {
                            if let spa_resort = amentiDict.value(forKey: "spa_resort") as? String
                            {
                                
                                if spa_resort == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                        }
                        
                        
                         else if indexPath.row == 16
                         {
                            if let swiming_facilities = amentiDict.value(forKey: "swiming_facilities") as? String
                            {
                                
                                if swiming_facilities == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            
                            }
                         }
                         else if indexPath.row == 17
                         {
                            if let venue_hire_only = amentiDict.value(forKey: "venue_hire_only") as? String
                            {
                                
                                if venue_hire_only == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                            }
                        }
                         else if indexPath.row == 18
                         {
                            if let marquee_permit = amentiDict.value(forKey: "marquee_permit") as? String
                            {
                                if marquee_permit == "0"
                                {
                                    cell.amityLbl2.text = "No"
                                }
                                else
                                {
                                    cell.amityLbl2.text = "Yes"
                                    
                                }
                               
                            }
                        }

                    }
            }
          }
            
            
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoHeaderTableViewCell") as! PhotoHeaderTableViewCell
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoHeaderTableViewCell") as! PhotoHeaderTableViewCell
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0
        {
          let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoFirstSectTableViewCell") as! PhotoFirstSectTableViewCell
            
            cell.backgroundColor = UIColor.white
            
                                if let address = self.mainDict.value(forKey: "address") as? String
                                {
                                    cell.addressLbl.text = "Address: "   + address
                                }
                                if let address = self.mainDict.value(forKey: "address") as? String
                                {
                                    cell.addressLbl.text = "Address: "   + address
                                }
            if let type = self.mainDict.value(forKey: "type") as? String
            {
                if type.lowercased() == "v"
                {
                   cell.venueTypeLbl.text = "Venue"
                }
                else
                {
                  cell.venueTypeLbl.text = "Supplier" 
                }
                
            }
            

                                if let address = self.mainDict.value(forKey: "name") as? String
                                {
                                    self.headerLbl.text = address
                                }
                                if let address = self.mainDict.value(forKey: "name") as? String
                                {
                                    cell.hotelTitleLbl.text = address
                                }

                                if let amount = self.mainDict.value(forKey: "banner_image") as? String
                                {
                                      if amount != ""
                                      {
                                        let url1 = URL(string: amount)!
                                        cell.LongImg.sd_setImage(with: url1, completed: nil)
                                    }
                                  
                                }

                                if let address = self.mainDict.value(forKey: "guest") as? String
                                {
                                    cell.seatLbl.text = address
                                }

                                if let telephone_number = self.mainDict.value(forKey: "telephone_number") as? String
                                {
                                    cell.tellPhoneLbl.text = "Tel : " + telephone_number
                                    self.callToSend = telephone_number
                                }
            if let email = self.mainDict.value(forKey: "email") as? String
            {
                cell.emailLbl.text = "Email : " + email
                self.emailToSend = email
            }
            if let avgrating_persons = self.mainDict.value(forKey: "avgrating_persons") as? Int
            {
                if avgrating_persons > 1
                {
                    cell.totalNoOfRating.text =  "\(avgrating_persons)" + " Reviews"
                }
                else
                {
                   cell.totalNoOfRating.text =  "\(avgrating_persons)" + " Review"
                }
               
            }
            if let avgrating = self.mainDict.value(forKey: "avgrating") as? Int
            {
                cell.ratingUIView.rating =  Float(avgrating)
            }
            
            if let is_fav = self.mainDict.value(forKey: "is_fav") as? Int
            {
                if is_fav == 0
                {
                    cell.likeBtn.setImage(UIImage(named: "unFav"), for: .normal)
                }
                else
                {
                    cell.likeBtn.setImage(UIImage(named: "like"), for: .normal)
                }
                
            }
        
            cell.likeBtn.addTarget(self, action: #selector(likeBtnClick), for: .touchUpInside)
            
//                                if let address = self.mainDict.value(forKey: "qualification") as? String
//                                {
//                                    cell.ovrQalifLbl.text = address
//                                }

            return cell
        }
        else if section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoHeaderTableViewCell") as! PhotoHeaderTableViewCell
           cell.headerLbl.text = "Full Descrption"
           cell.backgroundColor = UIColor.white
            cell.arraowBtn.tag = section
            cell.allButton.tag = section
            if  selectedSection == section
            {
                cell.arraowBtn.setImage(UIImage(named: "dropdown-errow"), for: .normal)
              //  headercell.lineView.isHidden = true
                cell.buttomLine.isHidden = true
            }
            else
            {
                cell.arraowBtn.setImage(UIImage(named: "arrow"), for: .normal)
                //headercell.lineView.isHidden = false
                cell.buttomLine.isHidden = false
            }
            
            cell.arraowBtn.addTarget(self, action: #selector(HeaderClick), for: .touchUpInside)
             cell.allButton.addTarget(self, action: #selector(HeaderClick), for: .touchUpInside)
            return cell
        }
            else if section>1 && section < 6
        {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoHeaderTableViewCell") as! PhotoHeaderTableViewCell
                cell.headerLbl.text = arrayHeader[section]
                 cell.backgroundColor = UIColor.white
                cell.arraowBtn.tag = section
                cell.allButton.tag = section
            
            if let reviews =  self.mainDict.value(forKey: "reviews") as? NSArray
            {
                
            }
            
            
                if  selectedSection == section
                {
                    cell.arraowBtn.setImage(UIImage(named: "dropdown-errow"), for: .normal)
                    //  headercell.lineView.isHidden = true
                     cell.buttomLine.isHidden = true
                }
                else
                {
                    cell.arraowBtn.setImage(UIImage(named: "arrow"), for: .normal)
                    //headercell.lineView.isHidden = false
                     cell.buttomLine.isHidden = false
                }
                
                cell.arraowBtn.addTarget(self, action: #selector(HeaderClick), for: .touchUpInside)
                cell.allButton.addTarget(self, action: #selector(HeaderClick), for: .touchUpInside)
                return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoButtomHeaderTableViewCell") as! PhotoButtomHeaderTableViewCell
            
            if let book_status = self.mainDict.value(forKey: "book_status") as? String
            {
                self.BookStatus = "\(book_status)"
                if book_status == "0"
                {
                    cell.BookMark.backgroundColor = TABLESECTIONCOLOR
                }
                else
                {
                   cell.BookMark.backgroundColor = APPCOLOR
                }
                
                
            }
            else
            
            {
                self.BookStatus = "\(0)"
                cell.BookMark.backgroundColor = TABLESECTIONCOLOR
                
            }
            if let is_fav = self.mainDict.value(forKey: "is_fav") as? String
            {
                self.sortStatus = "\(is_fav)"
                if is_fav == "0"
                {
                    cell.ShortView.backgroundColor = TABLESECTIONCOLOR
                    cell.likeImg.image = UIImage(named: "unFav")
                }
                else
                {
                    cell.ShortView.backgroundColor = APPCOLOR
                    cell.likeImg.image = UIImage(named: "like")
                }
                
                
            }
            else
                
            {
                self.sortStatus = "\(0)"
                cell.ShortView.backgroundColor = TABLESECTIONCOLOR
                
            }
            cell.BookMark.addTarget(self, action: #selector(BookedClicked), for: .touchUpInside)
            cell.Review.addTarget(self, action: #selector(ReviewClicked), for: .touchUpInside)
            cell.VenuePhone.addTarget(self, action: #selector(VenuePhoneClicked), for: .touchUpInside)
            cell.VenueText.addTarget(self, action: #selector(VenueTextClicked), for: .touchUpInside)
            cell.VenueEmail.addTarget(self, action: #selector(VenueEmailClicked), for: .touchUpInside)
            cell.ShortList.addTarget(self, action: #selector(ShortListClicked), for: .touchUpInside)
            
             cell.backgroundColor = UIColor.white
            return cell
        }
        
        
    }
    @objc func HeaderClick(_ sender: UIButton)
    {
       
        
        if selectedSection == sender.tag
        {
            self.selectedSection = -1
            
            tableView.reloadData()
        }
        else
        {
            selectedSection = sender.tag
         
        }
        
//        if sender.tag == 2
//        {
//
//        }
//        else if sender.tag == 3
//        {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
//            vc.backHidden = "yes"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 0
        {
           return 550
        }
         else if section<6
         {
            return 56
        }
        else
         {
            return 200
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.000001
    }
    
    @objc func BookedClicked(_ sender:UIButton)
    {
        print("BookedClicked")
        
        self.fromBookMark = "yes"
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            self.BookMarkAndSortApi()
        }
        
    }
    @objc func ReviewClicked(_ sender:UIButton)
    {
//        print("ReviewClicked")
//
//
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VenueAllReviewViewController") as! VenueAllReviewViewController
//        vc.mainDict = self.mainDict
//
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
        vc.mainDict = self.mainDict
        vc.backHidden = "yes"
        vc.viewHide2 = "yes"
        vc.fromVenue = "yes"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func VenuePhoneClicked(_ sender:UIButton)
    {
        print("VenuePhoneClicked")
        if let url = URL(string: "tel://\(self.callToSend)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @objc func VenueTextClicked(_ sender:UIButton)
    {
        print("VenueTextClicked")
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendRequestViewController") as! SendRequestViewController
//        var dict = self.FilterArray.object(at: sender.tag) as!NSDictionary
//
//        if let id1 = dict.value(forKey: "login_id") as? String
//        {
//            vc.vendorId = id1
//        }
//        vc.titleText = "Message Venue"
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SendRequestViewController") as! SendRequestViewController
        vc.vendorId = self.login_id
        vc.titleText = "Message Venue"
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    @objc func VenueEmailClicked(_ sender:UIButton)
    {
        print("VenueEmailClicked")
        let email = self.emailToSend
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @objc func ShortListClicked(_ sender:UIButton)
    {
        print("ShortListClicked")
        self.fromBookMark = "no"
        
        if let login_id = self.mainDict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        
        if let is_fav = self.mainDict.value(forKey: "is_fav") as? String
        {
            
            self.likeStatus = "\(is_fav)"
        }
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            self.VenueLikeUnlikeAPI()
        }
        
    }
    @objc func likeBtnClick(_ sender: UIButton)
    {
        
        
        
      
        
        if let login_id = self.mainDict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        if let login_id = self.mainDict.value(forKey: "login_id") as? String
        {
            
            self.LikeId = login_id
        }
        
        if let is_fav = self.mainDict.value(forKey: "is_fav") as? String
        {
            
            self.likeStatus = is_fav
        }
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
            self.VenueLikeUnlikeAPI()
        }
        
        
    }
    
    
    func detailApi()
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
        
        
        
        let params:[String:Any] = [
            "email":userEmail,
            "id":self.id,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEDETAILS, parameters: params) { (response, error) in
            if error == nil
            {
                
                self.DetailModel = Mapper<VenueDetailsModel>().map(JSONObject: response)
                
                if self.DetailModel.status == "success"
                {
                    self.mainDict = ((response as! NSDictionary).value(forKey: "data") as! NSDictionary)

                    self.tableView.reloadData()
                    
                    
                }
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                }
                
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    func BookMarkAndSortApi()
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
        var finalBookStatus = ""
        var finalShortStatus = ""
        
        if self.fromBookMark == "yes"
        {
            if self.BookStatus == "0"
            {
                finalBookStatus = "1"
            }
            else
            {
                finalBookStatus = "0"
                
            }
            finalShortStatus = ""
        }
        else
        {
            if self.sortStatus == "0"
            {
                finalShortStatus = "1"
            }
            else
            {
                finalShortStatus = "0"
                
            }
           finalBookStatus = ""
        }
        
        let params:[String:Any] = [
            "email":userEmail,
            "venue_id":self.login_id,
            "event_id":eventID,
            "event_type":eventType,
            "book_status":finalBookStatus,
            "sort_status":finalShortStatus]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUEBOOKMARKANDSORT, parameters: params) { (response, error) in
            if error == nil
            {
                
                print("Response in bookMark api \(response)")
            self.detailApi()
                
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    func VenueLikeUnlikeAPI()
    {
        
        
        var likeStatus2 = "1"
        var userEmail = ""
        if let email = DEFAULT.value(forKey: "email") as? String
        {
            userEmail = email
        }
        if self.likeStatus == "0"
        {
            likeStatus2 = "1"
        }
        else
        {
            likeStatus2 = "0"
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
            "venue_id":self.LikeId,
            "status":likeStatus2,
            "event_id":eventID,
            "event_type":eventType]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:VENUELIKEUNLIKE, parameters: params) { (response, error) in
            if error == nil
            {
                if let message = (response as! NSDictionary).value(forKey: "message") as? String
                {
                    self.view.makeToast(message)
                }
                
                
            self.detailApi()
            }
                
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        DEFAULT.set("yes", forKey: "FromDeatail")
        DEFAULT.synchronize()
        
        self.navigationController?.popViewController(animated: true)
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
