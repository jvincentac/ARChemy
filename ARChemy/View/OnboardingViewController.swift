//
//  OnboardingViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 15/01/21.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func lanjutkanBtn(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "isOnboarding")
        
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}
