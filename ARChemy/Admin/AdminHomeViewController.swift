//
//  AdminHomeViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit
import FirebaseDatabase

class AdminHomeViewController: UIViewController {

    @IBOutlet weak var combineTableView: UITableView!
    @IBOutlet weak var haiLabel: UILabel!
    
    var database: DatabaseReference?
    
    var teacher: [String:Any] = [:]
    var materi: [String: [String]] = [:]
    var latihan: [String: [String]] = [:]
    var teacherName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        database = Database.database().reference()
        
        configurePage()
    }

    @IBAction func addMateriBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMaterial") as! NewMateriViewController
        
        sb.modalPresentationStyle = .fullScreen
        sb.materi = self.materi
        sb.teacher = self.teacher
        sb.teacherName = self.teacherName
        
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func addLatihanBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewLatihan") as! NewLatihanViewController
        
        sb.modalPresentationStyle = .fullScreen
        sb.latihan = latihan
        sb.teacher = self.teacher
        sb.teacherName = self.teacherName
        
        present(sb, animated: true, completion: nil)
    }
}

extension AdminHomeViewController {
    func configurePage() {
        database?.child(teacherName).observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            
            self.teacher = value
            self.materi = value["materi"] as! [String: [String]]
            self.latihan = value["latihan"] as! [String: [String]]
        })
        
        haiLabel.text = "Hai, \(teacherName)!"
    }
}

extension AdminHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < latihan.count {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewLatihan") as! NewLatihanViewController
            
            sb.modalPresentationStyle = .fullScreen
            sb.latihan = latihan
            sb.teacher = self.teacher
            sb.teacherName = self.teacherName
            sb.isEdit = true
            sb.judul = Array(latihan.keys)[indexPath.row]
            
            present(sb, animated: true, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMaterial") as! NewMateriViewController
            
            sb.modalPresentationStyle = .fullScreen
            sb.materi = self.materi
            sb.teacher = self.teacher
            sb.teacherName = self.teacherName
            sb.isEdit = true
            sb.judul = Array(materi.keys)[indexPath.row - latihan.count]
            
            present(sb, animated: true, completion: nil)
        }
    }
}

extension AdminHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materi.count + latihan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CombineCell")
        
        var word = ""
        if indexPath.row < self.latihan.count {
            word = "L = \(Array(latihan.keys)[indexPath.row])"
        }
        else {
            word = "M = \(Array(materi.keys)[indexPath.row - latihan.count])"
        }
        
        cell.textLabel?.text = word
        
        return cell
    }
}