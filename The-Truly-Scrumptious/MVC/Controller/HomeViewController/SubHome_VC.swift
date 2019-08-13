//
//  SubHome_VC.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 28/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class SubHome_VC: UIViewController,UIGestureRecognizerDelegate {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var weddingImage: UIImageView!
    
    @IBOutlet weak var celebrationView: UIView!
    
    @IBOutlet weak var occasionImage: UIImageView!
    
    @IBOutlet weak var weddingView: UIView!
    
    
    var eventType:String = ""
    var eventID:String = ""
    
    var backButton1:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if backButton1 == "yes"
        {
            backButton.isHidden = false
        }
        else{
            backButton.isHidden = true

        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.delegate = self // This is not required
        weddingView.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2))
        tap1.delegate = self // This is not required
        celebrationView.addGestureRecognizer(tap1)
        
        
        let Img1 = UITapGestureRecognizer(target: self, action: #selector(self.profileImg1Click))
        Img1.delegate = self // This is not required
        weddingImage.addGestureRecognizer(Img1)
        
        let Img2 = UITapGestureRecognizer(target: self, action: #selector(self.profileImg2Click))
        Img2.delegate = self // This is not required
        occasionImage.addGestureRecognizer(Img2)
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @objc func handleTap()
    {
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//
//        let navVC = UINavigationController.init(rootViewController: vc)
//        navVC.setNavigationBarHidden(true, animated: true)
//        if let window = UIApplication.shared.windows.first
//        {
//            window.rootViewController = navVC
//            window.makeKeyAndVisible()
//        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "WeddingViewController") as! WeddingViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc func handleTap2()
    {
        
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//        UserDefaults.standard.set("yes", forKey: "FromRegister")
//        let navVC = UINavigationController.init(rootViewController: vc)
//        navVC.setNavigationBarHidden(true, animated: true)
//        if let window = UIApplication.shared.windows.first
//        {
//            window.rootViewController = navVC
//            window.makeKeyAndVisible()
//        }
        let vc = storyboard?.instantiateViewController(withIdentifier: "CelebrationViewController") as! CelebrationViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func profileImg1Click()
    {
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        //  UserDefaults.standard.set("yes", forKey: "FromRegister")
        // vc.hideMainView = ""
        let navVC = UINavigationController.init(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        if let window = UIApplication.shared.windows.first
        {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
        //        print("fedwgefhnf")
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
        //
    }
    @objc func profileImg2Click()
    {
        
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        UserDefaults.standard.set("yes", forKey: "FromRegister")
        let navVC = UINavigationController.init(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: true)
        if let window = UIApplication.shared.windows.first
        {
            window.rootViewController = navVC
            window.makeKeyAndVisible()
        }
        
        
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    @IBAction func weddingAction(_ sender: UIButton) {
    //
    //
    //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    //        // vc.hideMainView = ""
    //        let navVC = UINavigationController.init(rootViewController: vc)
    //        navVC.setNavigationBarHidden(true, animated: true)
    //        if let window = UIApplication.shared.windows.first
    //        {
    //            window.rootViewController = navVC
    //            window.makeKeyAndVisible()
    //        }
    //    }
    
    //    @IBAction func celebrationAction(_ sender: UIButton) {
    //
    //
    //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
    //
    //        let navVC = UINavigationController.init(rootViewController: vc)
    //        navVC.setNavigationBarHidden(true, animated: true)
    //        if let window = UIApplication.shared.windows.first
    //        {
    //            window.rootViewController = navVC
    //
    //            window.makeKeyAndVisible()
    //        }
    //    }
    
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
}
