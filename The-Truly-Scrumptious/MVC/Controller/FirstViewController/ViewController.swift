//
//  ViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 13/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func loginAction(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    @IBAction func registerAction(_ sender: UIButton)
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

