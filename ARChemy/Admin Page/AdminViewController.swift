//
//  AdminViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 14/01/21.
//

import UIKit

class AdminViewController: UIViewController {
    
    var ListMateriAdmin : [String] = ["Test","123"]
    var ListLatihanAdmin : [String] = ["Oi","asdsada"]

    @IBOutlet weak var adminTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminTableView.delegate = self
        adminTableView.dataSource = self
        adminTableView.register(AdminTableViewCell.nib(), forCellReuseIdentifier: AdminTableViewCell.identifier)
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

extension AdminViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ada")
    }
}

extension AdminViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListMateriAdmin.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let adminCell = adminTableView.dequeueReusableCell(withIdentifier: AdminTableViewCell.identifier, for: indexPath) as! AdminTableViewCell
        
        adminCell.configure(with: ListMateriAdmin[indexPath.row], imageName: "" )
        
        return adminCell
    
    }
    
    
}
