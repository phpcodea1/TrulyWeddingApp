//
//  PinBoardViewController.swift
//  TrulyApp
//
//  Created by eWeb on 5/17/19.
//  Copyright © 2019 eWeb. All rights reserved.
//

import UIKit

class PinBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UIGestureRecognizerDelegate
{
    
    var imageArray = [String]()
    var nameArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    imageArray = ["1-1","3","pic1","pic2","5","pic2","pic3","pic4","pic3","5","pic1","5","pic3","5"]
    nameArray = [" title1"," title2"," title3"," title4"," title5"," title6"," title7"," title8"," title9"," title10"," title11"," title12"," title13"," title14"]
    }
    
   
  
    @objc func ImageClick()
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsPinBoardViewController") as! DetailsPinBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func BackAct(_ sender: UIButton)
    {
  self.navigationController?.popViewController(animated: true)
    }
    @IBAction func startBtnAct(_ sender: UIButton)
    {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddToPinBoardViewController") as! AddToPinBoardViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        return imageArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "WeddingSupplierTableViewCell") as? WeddingSupplierTableViewCell
//        //cell?.dataLabel.text = imageArray[indexPath.item]
//        cell?.imageView?.image = UIImage(named: imageArray[indexPath.row])
//
//
//        return cell!
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinCollectionViewCell", for: indexPath) as! PinCollectionViewCell
      
       
        cell.pinImages.image = UIImage(named: imageArray[indexPath.item])
        cell.pinLabel.text = nameArray[indexPath.item]
        return cell
    }

    
    
    
    
}



extension PinBoardViewController:UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize
    {
      
        
        let cellWidth : CGFloat = UIScreen.main.bounds.width / 2.0
        let cellheight = (UIScreen.main.bounds.height-154)  / 3.0
        
        return CGSize(width: cellWidth-1, height: cellheight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 1.0
    }
}
