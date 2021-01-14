//
//  LatihanViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 03/01/21.
//

import Foundation
import UIKit

class LatihanViewController: UIViewController {

    @IBOutlet weak var LatihanTableView: UITableView!
    
    var ListLatihan :[String] = ["Latihan 1","Latihan 2","Latihan 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LatihanTableView.register(LatihanTableViewCell.nib(), forCellReuseIdentifier: LatihanTableViewCell.identifier)
        LatihanTableView.delegate = self
        LatihanTableView.dataSource = self
        
        LatihanTableView.backgroundColor = .white
        
        LatihanTableView.separatorStyle = .none
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension LatihanViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Quiz") as! QuizViewController
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension LatihanViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListLatihan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let LatihanCell = LatihanTableView.dequeueReusableCell(withIdentifier: LatihanTableViewCell.identifier, for: indexPath) as! LatihanTableViewCell
        LatihanCell.configure(with: ListLatihan[indexPath.row], imageName: "modeAR")
        

        return LatihanCell
    }
}


