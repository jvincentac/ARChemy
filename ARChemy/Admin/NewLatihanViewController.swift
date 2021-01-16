//
//  NewLatihanViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit
import FirebaseDatabase

class NewLatihanViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var w1TextField: UITextField!
    @IBOutlet weak var w2TextField: UITextField!
    @IBOutlet weak var w3TextField: UITextField!
    
    var isEdit: Bool = false
    var database: DatabaseReference?
    
    var teacher: [String:Any] = [:]
    var latihan: [String: [String]] = [:]
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
            questionTextField.clearsOnInsertion = true
            correctAnswerTextField.clearsOnBeginEditing = true
            w1TextField.clearsOnBeginEditing = true
            w2TextField.clearsOnBeginEditing = true
            w3TextField.clearsOnBeginEditing = true
        }
        
        correctAnswerTextField.layer.borderWidth = 1
        correctAnswerTextField.layer.borderColor = .init(red: 0, green: 255, blue: 0, alpha: 1)
        
        w1TextField.layer.borderWidth = 1
        w1TextField.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        
        w2TextField.layer.borderWidth = 1
        w2TextField.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        
        w3TextField.layer.borderWidth = 1
        w3TextField.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        saveLatihan(judul: titleTextField.text!, pertanyaan: questionTextField.text!, benar: correctAnswerTextField.text!, salah1: w1TextField.text!, salah2: w2TextField.text!, salah3: w3TextField.text!)
        back()
    }
}

extension NewLatihanViewController {
    func configurePage() {
        
    }
    
    func back() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.teacherName = teacherName
        present(sb, animated: true, completion: nil)
    }
    
    func saveLatihan(judul: String, pertanyaan: String, benar: String, salah1: String, salah2: String, salah3: String) {
        
        if Array(latihan.keys).contains(judul) {
            print("Judul Harus Unik")
        }
        else {
            if isEdit {
                latihan["\(self.judul)"] = []
            }
            
            latihan["\(judul)"] = [judul,pertanyaan,benar,salah1,salah2,salah3]
            teacher["latihan"] = latihan
            
            database?.child(teacherName).setValue(teacher)
        }
    }
}
