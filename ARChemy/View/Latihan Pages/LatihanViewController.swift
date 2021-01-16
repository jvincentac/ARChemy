//
//  LatihanViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 03/01/21.
//

import Foundation
import UIKit
import FirebaseDatabase

class LatihanViewController: UIViewController{

    @IBOutlet weak var LatihanTableView: UITableView!
    @IBOutlet weak var searchGuruTextField: UITextField!
    
    var latihan: [String: [String]] = [:]
    
    var teacherName = UserDefaults.standard.string(forKey: "latihanTeacherName")
    
    var database: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Database.database().reference()
        
        LatihanTableView.register(LatihanTableViewCell.nib(), forCellReuseIdentifier: LatihanTableViewCell.identifier)
        LatihanTableView.delegate = self
        LatihanTableView.dataSource = self
        
        LatihanTableView.backgroundColor = .white
        
        configurePage(name: teacherName!)
        searchGuruTextField.text = teacherName
        searchGuruTextField.delegate = self
        
        if searchGuruTextField.text == "Masukkan Nama Guru" {
            searchGuruTextField.clearsOnBeginEditing = true
        }
        
    }
    
    @IBAction func logOutBtn(_ sender: Any) {
        logOut()
    }
    
    @IBAction func CariBtn(_ sender: Any) {
        configurePage(name: searchGuruTextField.text!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension LatihanViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}

extension LatihanViewController {
    func configurePage(name: String) {
        database?.child(name).observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                self.latihan.removeAll()
                self.LatihanTableView.reloadData()
                return
            }
            self.latihan = value["latihan"] as! [String: [String]]
            self.LatihanTableView.reloadData()
            UserDefaults.standard.setValue(name, forKey: "latihanTeacherName")
        })
    }
}

extension LatihanViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Quiz") as! QuizzViewController

        sb.question = latihan[Array(latihan.keys)[indexPath.row]]![1]
        sb.correctAnswer = latihan[Array(latihan.keys)[indexPath.row]]![2]
        sb.w1 = latihan[Array(latihan.keys)[indexPath.row]]![3]
        sb.w2 = latihan[Array(latihan.keys)[indexPath.row]]![4]
        sb.w3 = latihan[Array(latihan.keys)[indexPath.row]]![5]

        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension LatihanViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latihan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let LatihanCell = LatihanTableView.dequeueReusableCell(withIdentifier: LatihanTableViewCell.identifier, for: indexPath) as! LatihanTableViewCell
        LatihanCell.configure(with: Array(latihan.keys)[indexPath.row], imageName: "modeAR")

        return LatihanCell
    }
}


