//
//  CheckListViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 17/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//


import UIKit
import Alamofire
import ObjectMapper
//import SVProgressHUD

class CheckListViewController: UIViewController
{
    @IBOutlet weak var nodataLbl: UILabel!
    var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 20.0)
    
    let maximumTime : Float = 10.0
    var currentTime : Float = 0.0
  var fromBack = ""
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var backBtn: UIButton!
    @IBOutlet weak var fillView: UIView!
    //Outlets for view line colors.
    @IBOutlet weak var todolineview: UIView!
    @IBOutlet weak var donelineview: UIView!
    @IBOutlet weak var alllineview: UIView!
    
    
    @IBOutlet weak var progressLabel: UILabel!
    //    @IBOutlet weak var maximumaTasksLabel: UILabel!
    //    @IBOutlet weak var minumumTasksLabel: UILabel!
//    var checkToDoModel:ToDoTaskListModel!
//    var checkToDoModelData:[TaskData]!
//    var deleteListModel:ToDoListDeleteModel!
//    var checkListPostModel:DoneTaskListModel!
    
    var iD = Int()
    var status = String()
    
    var isTodoSelected = true
    var isDoneSelected = false
    var isAllSelected = false
    var selectedButton = "Todo"
    var selectedbtnID = Int()
    var nameArray = [String]()
    
    var taskCount:String = ""
    var minmumCheckTaskCount:String = ""
    
    var back:String = ""
    
    var ToDoArrayList = NSMutableArray()
    
    var AllArrayList = NSMutableArray()
    var DoneArrayList = NSMutableArray()
    
    
    var clicked_task_id = ""
    
     var delete_task_id = ""
     var clicked_task_status = ""
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.nodataLbl.isHidden = false
        
  progressView.transform = transform
       
//        fillView.clipsToBounds = true
//        fillView.layer.cornerRadius = 10
//        fillView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.nameArray = ["Task Name 1","Task Name 2","Task Name 3","Task Name 4","Task Name 5"]
        
       progressView.layer.cornerRadius = 8 //progressView.frame.height/2..
      //  progressView.layer.masksToBounds = true
       //  progressView.clipsToBounds = true
        
//
        progressView.progressTintColor = APPCOLOR
        progressView.trackTintColor = UIColor.lightGray
        
        
        //        self.minumumTasksLabel.text! =  minmumCheckTaskCount + "task"
        //        self.maximumaTasksLabel.text! =  taskCount + "tasks"
        //
        tableview.tableFooterView = UIView()
//        
//        if fromBack == "yes"
//        {
//            self.backBtn.isHidden = false
//            
//        }
//        else
//        {
//            self.backBtn.isHidden = true
//            
//        }
//       
        
        //View lines colors handling  default.
      
        
      
        self.todolineview.isHidden = false
        self.donelineview.isHidden = true
        self.alllineview.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            
               AllTODOLISTAPI()
        }
    
        self.nodataLbl.text = "No Data Found"
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        
        
//        if back == "yes"
//        {
          self.navigationController?.popViewController(animated: true)
      //  }
//        else{
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//            // vc.hideMainView = ""
//            let navVC = UINavigationController.init(rootViewController: vc)
//            navVC.setNavigationBarHidden(true, animated: true)
//            SCANNERDATA = "X"
//            if let window = UIApplication.shared.windows.first
//            {
//                window.rootViewController = navVC
//                window.makeKeyAndVisible()
//            }
//        }
       
        
//                    let targetVc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//
//                        print("Amarendra tab click")
//                        let appDelRef = UIApplication.shared.delegate as! AppDelegate
//                        let rootWindow = appDelRef.window
//                        targetVc.selectedIndex = 0
//                        rootWindow!.rootViewController = targetVc
//                        SCANNERDATA = "2"
//                        rootWindow?.makeKeyAndVisible()
//                        UIApplication.shared.endIgnoringInteractionEvents()
        
        
         //NotificationCenter.default.post(name: Notification.Name("DidSelectCollection"), object: self)
        
       // self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addButton(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    // MARK:- Progress View
    
    //
  //  @objc func updateProgress()
//    {
//        //        currentTime = currentTime + 1.0
//        //        progressView.progress = currentTime / maximumTime
//        //
//        //        self.maximumaTasksLabel.text = "\(maximumTime)"
//        //        self.minumumTasksLabel.text! = "\(currentTime)"
//        //        if currentTime < maximumTime
//        //        {
//        //            perform(#selector(updateProgress),with:nil ,afterDelay:3.0)
//        //
//        //        }
//        //        else
//        //        {
//        //
//        //            print("stop")
//        //            currentTime = 0.0
//        //        }
//
//     //   if let data = checkToDoModelData, data.count > 0
////        {
////
////            if selectedButton == "DoneBtn"
////            {
////                let model = data.filter() { $0.status == "1" }
////                // self.progressLabel.text = "You have completed " + String(model.count) + "task out of " + String(data.count) + "tasks"
////                progressView.progress = Float(model.count)/Float(data.count)
////                if model.count < data.count
////                {
////                    perform(#selector(updateProgress),with:nil ,afterDelay:1.0)
////                }
////                else{
////                    print("stop")
////                }
////            }
////            if selectedButton == "Todo"
////            {
////                let model = data.filter() { $0.status == "1" }
////                //self.progressLabel.text = "You have completed " + String(model.count) + "task out of " + String(data.count) + "tasks"
////                progressView.progress = Float(model.count)/Float(data.count)
////                if model.count < data.count
////                {
////                    perform(#selector(updateProgress),with:nil ,afterDelay:1.0)
////                }
////                else{
////                    print("stop")
////                }
////            }else{
////                // self.progressLabel.text = "You have completed " + String(data.count) + "task out of " + String(data.count) + "tasks"
////                progressView.progress = Float(data.count)/Float(data.count)
////                if data.count < data.count
////                {
////                    perform(#selector(updateProgress),with:nil ,afterDelay:1.0)
////                }
////                else{
////                    print("stop")
////                }
////            }
////        }
//
//
//
//    }
    
    
    
    
    
    
    
    
    @IBAction func todoAction(_ sender: UIButton) {
        
//        checkListToDoAPI()
//
//        progressView.setProgress(currentTime, animated: true)
//        perform(#selector(updateProgress),with:nil ,afterDelay:3.0)
        
        
        
        viewlineColor(showview: todolineview, hideview1: donelineview, hideview2: alllineview)
        self.isTodoSelected = true
        self.isDoneSelected = false
        isTodoSelected = false
        
        self.selectedButton = "Todo"
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            self.AllTODOLISTAPI()
        }
        
         if self.ToDoArrayList.count==0
        {
            self.nodataLbl.isHidden = false
        }
        
        else
        {
            self.nodataLbl.isHidden = true
        }
        //tableview.reloadData()
        
    }
    
    @IBAction func DoneAction(_ sender: UIButton) {
        //
//        progressView.setProgress(currentTime, animated: true)
//        perform(#selector(updateProgress),with:nil ,afterDelay:3.0)
//
        viewlineColor(showview: donelineview, hideview1: todolineview, hideview2: alllineview)
        isDoneSelected = true
        isTodoSelected = false
        isTodoSelected = false
        self.selectedButton = "DoneBtn"
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            self.AllTODOLISTAPI()
        }
        if self.DoneArrayList.count==0
        {
            self.nodataLbl.isHidden = false
        }
            
        else
        {
            self.nodataLbl.isHidden = true
        }
        tableview.reloadData()
        
    }
    
    @IBAction func allAction(_ sender: UIButton) {
        
//        progressView.setProgress(currentTime, animated: true)
//        perform(#selector(updateProgress),with:nil ,afterDelay:3.0)
        //
        
        
        
        viewlineColor(showview: alllineview, hideview1: todolineview, hideview2: donelineview)
        self.isTodoSelected = false
        self.isDoneSelected = false
        isTodoSelected = true
        self.selectedButton = "AllBtn"
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            self.AllTODOLISTAPI()
        }
        
        tableview.reloadData()
        
    }
    
    @IBAction func addAction(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewTaskViewController") as! NewTaskViewController
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK:- View line colors handling Function
    func viewlineColor(showview:UIView,hideview1:UIView,hideview2:UIView)
    {
        showview.isHidden = false
        hideview1.isHidden = true
        hideview2.isHidden = true
    }
    
    
    
}

//MARK:- Tableview Data Handling.
extension CheckListViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if selectedButton == "Todo"
        {

            if self.ToDoArrayList.count==0
            {
                self.nodataLbl.isHidden = false
            }
                
            else
            {
                self.nodataLbl.isHidden = true
            }
       return ToDoArrayList.count
   
        }
        else if selectedButton == "DoneBtn"
        {
            if self.DoneArrayList.count==0
            {
                self.nodataLbl.isHidden = false
            }
                
            else
            {
                self.nodataLbl.isHidden = true
            }
        return DoneArrayList.count
            
        }
        else if selectedButton == "AllBtn"
        {
            if self.AllArrayList.count==0
            {
                self.nodataLbl.isHidden = false
            }
                
            else
            {
                self.nodataLbl.isHidden = true
            }
        return AllArrayList.count
        }
        return 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // if isTodoSelected
        if selectedButton == "Todo"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Check_To_TableViewCell") as! Check_To_TableViewCell
     
            var dict = self.ToDoArrayList.object(at: indexPath.row) as! NSDictionary
            
            if let task_category_name = dict.value(forKey: "task_category_name") as? String
            {
                cell.titileLabel.text! = task_category_name
            }
            
            if let task_name = dict.value(forKey: "task_name") as? String
            {
                cell.checkToLabel.text! = task_name
            }
            if let created_at = dict.value(forKey: "created_at") as? String
            {
                cell.timingLabel.text! = self.convertDateFormater(created_at)
            }
            
            if let done_status = dict.value(forKey: "done_status") as? String
            {
                if done_status == "1"
                {
                    cell.checkButton.setImage(UIImage(named: "right-true"), for: .normal)
                }
                else
                {
                    cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
                }
            }
            else
            {
                cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
            }
            
            
            
            cell.checkButton.tag = indexPath.row
            
            cell.checkButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
       
            cell.deleteBtn.tag = indexPath.row
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            return cell
            
        }
        else if selectedButton == "DoneBtn"
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Check_Done_TableViewCell") as! Check_Done_TableViewCell

            var dict = self.DoneArrayList.object(at: indexPath.row) as! NSDictionary
            
            if let task_category_name = dict.value(forKey: "task_category_name") as? String
            {
                cell.titileLabel.text! = task_category_name
            }
            
            if let task_name = dict.value(forKey: "task_name") as? String
            {
                cell.checkDoneLabel.text! = task_name
            }
            if let created_at = dict.value(forKey: "created_at") as? String
            {
                cell.timingLabel.text! = self.convertDateFormater(created_at)
            }
            
            if let done_status = dict.value(forKey: "done_status") as? String
            {
                if done_status == "1"
                {
                    cell.checkButton.setImage(UIImage(named: "right-true"), for: .normal)
                   
                }
                else
                {
                    cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
                 
                }
            }
            else
            {
                
                cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
            }
            
            
            
            cell.checkButton.tag = indexPath.row
            
            cell.checkButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
            cell.deleteBtn.tag = indexPath.row
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)

            return cell
        }
        else if selectedButton == "AllBtn"
        
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Check_All_TableViewCell") as! Check_All_TableViewCell
            
            
            var dict = self.AllArrayList.object(at: indexPath.row) as! NSDictionary
            
            if let task_category_name = dict.value(forKey: "task_category_name") as? String
            {
                  cell.titleLabel.text! = task_category_name
            }
            
            if let task_name = dict.value(forKey: "task_name") as? String
            {
                cell.checlAllLabel.text! = task_name
            }
            if let created_at = dict.value(forKey: "created_at") as? String
            {
                cell.timingLabel.text! = self.convertDateFormater(created_at)
            }
            
            if let done_status = dict.value(forKey: "done_status") as? String
            {
                if done_status == "1"
                {
                   cell.checkButton.setImage(UIImage(named: "right-true"), for: .normal)
                     cell.crossView.isHidden=false
                }
                else
                {
                   cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
                     cell.crossView.isHidden=true
                }
            }
            else
            {
               cell.checkButton.setImage(UIImage(named: "check-mark"), for: .normal)
                cell.crossView.isHidden=true
            }

            
            
            cell.checkButton.tag = indexPath.row
            
                cell.checkButton.addTarget(self, action: #selector(checkMarkButtonClicked(sender:)), for: .touchUpInside)
    
            cell.deleteBtn.tag = indexPath.row
            
            cell.deleteBtn.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
            return cell
        }
        else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        var dict = self.AllArrayList.object(at: indexPath.row) as! NSDictionary
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
        vc.fromEdit = "yes"
        vc.TaskData = dict
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    
    @objc func checkMarkButtonClicked ( sender: UIButton)
    {
        print("button presed")

        
        var dict = NSDictionary()
        
        if selectedButton == "Todo"
        {
            dict = self.ToDoArrayList.object(at: sender.tag) as! NSDictionary
        }
        else if selectedButton == "DoneBtn"
        {
            dict = self.DoneArrayList.object(at: sender.tag) as! NSDictionary
        }
        else if selectedButton == "AllBtn"
            
        {
            dict = self.AllArrayList.object(at: sender.tag) as! NSDictionary
        }
        
        
        if let id = dict.value(forKey: "id") as? String
        {
            self.clicked_task_id = id
        }
        
        if let done_status = dict.value(forKey: "done_status") as? String
        {
            self.clicked_task_status = done_status
        }
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
        {
            self.DOUNDOLISTAPI()
        }
       
    }
    @objc func deleteButtonClicked ( sender: UIButton)
    {
        print("button presed")
        
        
        var dict = NSDictionary()
        
        if selectedButton == "Todo"
        {
            dict = self.ToDoArrayList.object(at: sender.tag) as! NSDictionary
        }
        else if selectedButton == "DoneBtn"
        {
            dict = self.DoneArrayList.object(at: sender.tag) as! NSDictionary
        }
        else if selectedButton == "AllBtn"
            
        {
            dict = self.AllArrayList.object(at: sender.tag) as! NSDictionary
        }
        
        
        if let id = dict.value(forKey: "id") as? String
        {
            self.delete_task_id = id
        }
        
        if !(NetworkEngine.networkEngineObj.isInternetAvailable())
        {
            NetworkEngine.networkEngineObj.showInterNetAlert()
        }
        else
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
                    self.DELETEAPI()
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
        
    
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func AllTODOLISTAPI()
    {
        var eventType = "wedding"
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
            "event_type":eventType,
            "event_id":eventID
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:GETALLLIST, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                if let dict = response as? NSDictionary
                {
                    
                    if self.ToDoArrayList.count>0
                    {
                        self.ToDoArrayList.removeAllObjects()
                    }
                    if self.AllArrayList.count>0
                    {
                        self.AllArrayList.removeAllObjects()
                    }
                    if self.DoneArrayList.count>0
                    {
                        self.DoneArrayList.removeAllObjects()
                    }
                    
                    if let data = (dict.value(forKey: "data")) as? NSArray
                    {
                        self.AllArrayList = data.mutableCopy() as! NSMutableArray
                        
                        for i in 0..<self.AllArrayList.count
                        {
                            var dict = self.AllArrayList.object(at: i) as! NSDictionary
                            
                            if let done_status = dict.value(forKey: "done_status") as? String
                            {
                                if done_status == "1"
                                {
                                   self.DoneArrayList.add(dict)
                                }
                                else
                                {
                                     self.ToDoArrayList.add(dict)
                                }
                            }
                            else
                            {
                                self.ToDoArrayList.add(dict)
                            }
                        }
                    }
                    
                    var str1 = "You have completed " + "\(self.DoneArrayList.count)" + " out of "
                    self.progressLabel.text = str1 + "\(self.AllArrayList.count)" + " tasks"
                    
                }
             //   var dev = (self.ToDoArrayList.count)/(self.AllArrayList.count)
                
                if self.ToDoArrayList.count>0 || self.AllArrayList.count>0
                {
                    if self.ToDoArrayList.count == self.AllArrayList.count
                    {
                         self.progressView.setProgress(0, animated: true)
                    }
                    else if self.ToDoArrayList.count == 0
                    {
                         self.progressView.setProgress(1, animated: true)
                    }
                    else
                    {
                        
                        var percent = Float(self.ToDoArrayList.count)/Float(self.AllArrayList.count)
                        
                        
                        self.nodataLbl.isHidden = true
                        print(percent)
                        
                        self.progressView.setProgress(percent, animated: true)
                    }
                   
                }
                else
                {
                    self.nodataLbl.isHidden = false
                    self.progressView.setProgress(0, animated: true)
                }
                
//                if self.DoneArrayList.count==0
//                {
//                    self.nodataLbl.isHidden = false
//                }
//              else  if self.ToDoArrayList.count==0
//                {
//                    self.nodataLbl.isHidden = false
//                }
//              else  if self.AllArrayList.count==0
//                {
//                    self.nodataLbl.isHidden = false
//                }
//                else
//                {
//                    self.nodataLbl.isHidden = true
//                }
                self.tableview.reloadData()
            }
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    func DOUNDOLISTAPI()
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
        var status = ""
        if let eventID1 = DEFAULT.value(forKey: "eventID") as? String
        {
            eventID = eventID1
        }
        
        if self.clicked_task_status == "0"
        {
            status = "1"
        }
        else
        {
             status = "0"
        }
        
        let params:[String:Any] = [
            "email":userEmail,
            "task_id":self.clicked_task_id,
            "status":status
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:DOUNDOLIST, parameters: params) { (response, error) in
            if error == nil
            {
            
                
                
                self.AllTODOLISTAPI()
            }
     
                else
                {
                    Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                    
                }
                
                
            }
            
        }
    
    func DELETEAPI()
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
            "task_id":self.delete_task_id,
           
        ]
        
        
        print(params)
        WebService.shared.apiDataPostMethod(url:REMOVETASK, parameters: params) { (response, error) in
            if error == nil
            {
                
                
                
                self.AllTODOLISTAPI()
            }
                
            else
            {
                Helper.helper.showAlertMessage(vc:self, titleStr: "Notification", messageStr: error?.localizedDescription ?? "")
                
            }
            
            
        }
        
    }
    
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return  dateFormatter.string(from: date!)
        
    }
}
