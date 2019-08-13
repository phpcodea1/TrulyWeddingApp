//
//  ListViewController.swift
//  The-Truly-Scrumptious
//
//  Created by APPLE on 14/05/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit
import FloatRatingView

class ListViewController: UIViewController {

    @IBOutlet weak var flot: FloatRatingView!
    override func viewDidLoad() {
        super.viewDidLoad()

        flot.rating = 3
        flot.delegate=self
        
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ListViewController: FloatRatingViewDelegate {
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float) {
        print(self.flot.rating)
    }
    
    
   
    
    
    
}
