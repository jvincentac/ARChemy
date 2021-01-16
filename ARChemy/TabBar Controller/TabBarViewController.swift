//
//  TabBarViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 16/01/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    @IBOutlet weak var ThreeMainBar: UITabBar!
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        
//        let indexTab = tabBar.items?.index(i, offsetBy: 3)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if(ThreeMainBar.selectedItem == UITabBarItem.in){
//            
//        }
        
        
        ThreeMainBar.selectedItem?.image = UIImage(named: "selectedModeAR")
        
//        ThreeMainBar.selectedImageTintColor = .white
//
        
//        ThreeMainBar.selectedItem.
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
