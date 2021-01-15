//
//  MateriViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 04/01/21.
//

import UIKit
import FirebaseDatabase

class MateriViewController: UIViewController {
    
    @IBOutlet weak var MateriTableView: UITableView!
    
    var ListMateri :[String] = ["Apa itu Proton?","Apa itu Neutron?","Apa itu Elektron?"]
    
    var database: DatabaseReference?
    
    var materi: [String: [String]] = [:]
    var teacherName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MateriTableView.delegate = self
        MateriTableView.dataSource = self
        
        MateriTableView.separatorStyle = .none
        MateriTableView.backgroundColor = .white
        
        MateriTableView.register(MateriTableViewCell.nib(), forCellReuseIdentifier: MateriTableViewCell.identifier)
        
        database = Database.database().reference()
        
        configurePage()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MateriViewController {
    func configurePage() {
        database?.child("Vincent").observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            self.materi = value["materi"] as! [String: [String]]
            self.MateriTableView.reloadData()
        })
    }
}

extension MateriViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ContentMateri") as! ContentMateriViewController
        
        let tempTitle = Array(materi.keys)[indexPath.row]
        let tempContent = materi[tempTitle]![1]
        
        sb.judul = tempTitle
        sb.konten = tempContent
        sb.modalPresentationStyle = .fullScreen
        
        present(sb, animated: true, completion: nil)
    }
}

extension MateriViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let MateriCell = MateriTableView.dequeueReusableCell(withIdentifier: MateriTableViewCell.identifier, for: indexPath) as! MateriTableViewCell
        MateriCell.configure(with: Array(materi.keys)[indexPath.row], imageName: "materi")
        return MateriCell
    }
}
