//
//  MYNoticeBoardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by administrator on 22/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class MYNoticeBoardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet var noticeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTable.delegate = self
        noticeTable.dataSource = self
        
        
        
        noticeTable.rowHeight = UITableView.automaticDimension
        self.noticeTable.rowHeight = 75
        // Do any additional setup after loading the view.
    }
    

    @IBAction func noticeboardAction(_ sender: UIButton) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddDescNoticeBoardViewController") as! AddDescNoticeBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return 10
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("NoticeTableViewCell", owner: self, options: nil)?.first as! NoticeTableViewCell
        return cell
        
    }
    
 
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    

}
