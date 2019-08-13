//
//  DetailsPinBoardViewController.swift
//  The-Truly-Scrumptious
//
//  Created by eWeb on 10/06/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

class DetailsPinBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource
{
  
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "DetailsImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsImageCollectionViewCell")
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
       
        let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsImageCollectionViewCell", for: indexPath) as! DetailsImageCollectionViewCell
        
        return cell2
        
    }
    @IBAction func goBack(_ sender: Any)
    {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    

}
extension DetailsPinBoardViewController:UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
       
        return CGSize(width: UIScreen.main.bounds.width-16, height: 300)

    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 5.0
    }
}
