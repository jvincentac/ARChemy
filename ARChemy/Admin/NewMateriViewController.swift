//
//  NewMateriViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit
import FirebaseDatabase

class NewMateriViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var materialTextField: UITextView!
    
    var isEdit: Bool = false
    var database: DatabaseReference?
    
    var teacher: [String:Any] = [:]
    var materi: [String: [String]] = [:]
    var teacherName = ""
    
    var judul = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        database = Database.database().reference()

        if isEdit {
            configurePage()
        }
        else {
            titleTextField.clearsOnBeginEditing = true
            materialTextField.clearsOnInsertion = true
        }
        
        materialTextField.backgroundColor = .white
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SaveBtn(_ sender: Any) {
        saveMaterial(judul: titleTextField.text!, isi: materialTextField.text!)
        back()
    }
}

extension NewMateriViewController {
    func configurePage() {
        titleTextField.text = materi[judul]![0]
        materialTextField.text = materi[judul]![1]
    }
    
    func back() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.teacherName = teacherName
        present(sb, animated: true, completion: nil)
    }
    
    func saveMaterial(judul: String, isi: String) {
        
        if titleTextField.text == "" || materialTextField.text == "" {
            makeAlert(title: "Gagal", desc: "Semua Harus Terisi")
        }
        else {
            if Array(materi.keys).contains(judul) && isEdit == false {
                print("Judul Harus Unik")
            }
            else {
                if isEdit {
                    if judul == self.judul {
                        print("Judul Tidak Boleh Sama")
                    }
                    else {
                        materi["\(self.judul)"] = []
                    }
                }
                
                materi["\(judul)"] = ["\(judul)","\(isi)"]
                teacher["materi"] = materi
                
                database?.child(teacherName).setValue(teacher)
            }
        }
    }
}
