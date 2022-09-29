//
//  QiblaViewController.swift
//  PrayerApp
//
//  Created by Bauyrzhan Marat on 26.08.2022.
//

import Foundation
import UIKit

class QiblaViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
   
    @IBOutlet weak var qiblaDirectionLabel: UILabel!
    
    
    @IBAction func goBackbutton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
