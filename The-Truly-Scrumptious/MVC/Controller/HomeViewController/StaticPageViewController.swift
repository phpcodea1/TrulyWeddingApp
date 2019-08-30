//
//  StaticPageViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 23/08/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import SVProgressHUD

class StaticPageViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webOutlet: UIWebView!
    var openpath = "http://112.196.9.211:8230/wp/privacy/"
    
    var titleShow = ""
    
    @IBOutlet weak var titlelbl: UILabel!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        webOutlet.delegate = self
        
        self.titlelbl.text = titleShow
        if openpath != nil
        {
            let url = URL(string: openpath)!
            webOutlet.loadRequest(URLRequest(url: url))
        }
       
    }
    
    func webViewDidStartLoad(_ webView: UIWebView)
    {
 SVProgressHUD.show()
        
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
       SVProgressHUD.dismiss()
    }
    @IBAction func goBack(_ sender: UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
