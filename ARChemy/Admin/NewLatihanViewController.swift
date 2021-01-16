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
        
        // test code
        initializeHideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // test code
        
        changeBorderToGreen()
        changeBorderToRed()
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
        
        questionTextField.backgroundColor = .white
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
        titleTextField.text = latihan[judul]![0]
        questionTextField.text = latihan[judul]![1]
        correctAnswerTextField.text = latihan[judul]![2]
        w1TextField.text = latihan[judul]![3]
        w2TextField.text = latihan[judul]![4]
        w3TextField.text = latihan[judul]![5]
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
                if judul == self.judul {
                    print("Judul Tidak Boleh Sama")
                }
                else {
                    latihan["\(self.judul)"] = []
                }
            }
            
            latihan["\(judul)"] = [judul,pertanyaan,benar,salah1,salah2,salah3]
            teacher["latihan"] = latihan
            
            database?.child(teacherName).setValue(teacher)
        }
    }
    
    func changeBorderToGreen(){
        let myColor = UIColor.green
          correctAnswerTextField.layer.borderColor = myColor.cgColor
    }
    
    func changeBorderToRed(){
        let myColor = UIColor.red
          w1TextField.layer.borderColor = myColor.cgColor
          w2TextField.layer.borderColor = myColor.cgColor
          w3TextField.layer.borderColor = myColor.cgColor
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension NewLatihanViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
