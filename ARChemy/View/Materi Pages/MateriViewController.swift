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
    @IBOutlet weak var searchGuruTextField: UITextField!
    
    
    var database: DatabaseReference?
    
    var materi: [String: [String]] = [:]
    var teacherName = UserDefaults.standard.string(forKey: "materiTeacherName")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MateriTableView.delegate = self
        MateriTableView.dataSource = self
        
        MateriTableView.separatorStyle = .none
        MateriTableView.backgroundColor = .white
        
        MateriTableView.register(MateriTableViewCell.nib(), forCellReuseIdentifier: MateriTableViewCell.identifier)
        
        database = Database.database().reference()
        
        configurePage(name: teacherName!)
        searchGuruTextField.text = teacherName
        
        if searchGuruTextField.text == "Masukkan Nama Guru" {
            searchGuruTextField.clearsOnBeginEditing = true
        }
    }
    
    @IBAction func cariBtn(_ sender: Any) {
        configurePage(name: searchGuruTextField.text!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MateriViewController {
    func configurePage(name: String) {
        database?.child(name).observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                self.materi.removeAll()
                self.MateriTableView.reloadData()
                return
            }
            self.materi = value["materi"] as! [String: [String]]
            self.MateriTableView.reloadData()
            UserDefaults.standard.setValue(name, forKey: "materiTeacherName")
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
        MateriCell.configure(with: Array(materi.keys)[indexPath.row])
        return MateriCell
    }
}
