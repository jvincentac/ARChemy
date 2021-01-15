//
//  AdminHomeViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit

class AdminHomeViewController: UIViewController {

    @IBOutlet weak var combineTableView: UITableView!
    @IBOutlet weak var haiLabel: UILabel!
    
    var latihanList: [Question] = []
    var materiList: [Material] = []
    var teacher: Teacher?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        latihanList = teacher?.questions?.allObjects as! [Question]
        
        materiList = teacher?.materials?.allObjects as! [Material]
        
        haiLabel.text = "Hai, \(teacher?.name ?? "")!"
    }

    @IBAction func addMateriBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMaterial") as! NewMateriViewController
        sb.isEdit = false
        sb.teacher = teacher
        sb.modalPresentationStyle = .fullScreen
        
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func addLatihanBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewLatihan") as! NewLatihanViewController
        sb.teacher = teacher
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension AdminHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < latihanList.count {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewLatihan") as! NewLatihanViewController
            sb.isEdit = true
            sb.teacher = teacher
            sb.question = latihanList[indexPath.row]
            sb.modalPresentationStyle = .fullScreen
            
            present(sb, animated: true, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewMaterial") as! NewMateriViewController
            sb.isEdit = true
            sb.teacher = teacher
            sb.material = materiList[indexPath.row - latihanList.count]
            sb.modalPresentationStyle = .fullScreen
            
            present(sb, animated: true, completion: nil)
        }
    }
}

extension AdminHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latihanList.count + materiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CombineCell")
        var word = ""
        
        if indexPath.row < latihanList.count {
            word = latihanList[indexPath.row].title!
        }
        else {
            word = materiList[indexPath.row - latihanList.count].title!
        }
        
        cell.textLabel?.text = word
        
        return cell
    }
}