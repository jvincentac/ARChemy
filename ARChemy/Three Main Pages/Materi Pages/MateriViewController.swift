//
//  MateriViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 04/01/21.
//

import UIKit

class MateriViewController: UIViewController {
    
    @IBOutlet weak var MateriTableView: UITableView!
    
    var ListMateri :[String] = ["Apa itu Proton?","Apa itu Neutron?","Apa itu Elektron?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MateriTableView.delegate = self
        MateriTableView.dataSource = self
        
        MateriTableView.register(MateriTableViewCell.nib(), forCellReuseIdentifier: MateriTableViewCell.identifier)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MateriViewController : UITableViewDelegate {
    
}

extension MateriViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListMateri.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MateriCell = MateriTableView.dequeueReusableCell(withIdentifier: MateriTableViewCell.identifier, for: indexPath) as! MateriTableViewCell
        MateriCell.configure(with: ListMateri[indexPath.row], imageName: "materi")
        return MateriCell
    }
    
    
}
