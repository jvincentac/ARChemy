//
//  TabBarViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 16/01/21.
// aa aa

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var ThreeMainBar: UITabBar!
    
    var idx = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ThreeMainBar.selectedItem?.image = UIImage(named: "selectedModeAR")
        
        self.selectedIndex = idx
    }
}
