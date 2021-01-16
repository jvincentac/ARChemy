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
        
        self.selectedIndex = idx
        
        if(self.selectedIndex == idx){
//            ThreeMainBar.selectedItem?.image = UIImage(named: "selectedModeAR")
            ThreeMainBar.backgroundColor = .white
            ThreeMainBar.tintColor  = UIColor(red: 141/255, green: 139/255, blue: 237/255, alpha: 1)
            
        }
    }
}
