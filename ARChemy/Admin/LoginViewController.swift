//
//  loginViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit
import FirebaseDatabase


class LoginViewController: UIViewController {
    
    private var database: DatabaseReference?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var name = ""
    var password = ""
    
    var warningTitle = "Berhasil"
    var warningDesc = "Silahkan Masuk Dengan Nama dan Password Anda"
    
    var teacher: [String: Any] = [:]
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        initializeHideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        if nameTextField.text != "" && passwordTextField.text != "" {
            login(name: nameTextField.text!, password: passwordTextField.text!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                if self.isLogin == true{
                    print("login success")
                    
                    let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
                    sb.modalPresentationStyle = .fullScreen
                    sb.teacher = self.teacher
                    sb.teacherName = nameTextField.text!

                    self.present(sb, animated: true, completion: nil)
                
                }
                else {
                    makeAlert(title: "Gagal", desc: "Nama atau Password salah")
                    nameTextField.endEditing(true)
                    passwordTextField.endEditing(true)
                }
            }
        }
        else {
            makeAlert(title: "Perhatian", desc: "Mohon Isi Nama dan Password")
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        if nameTextField.text != "" && passwordTextField.text != "" {
            addNewTeacher(name: nameTextField.text!, password: passwordTextField.text!)
            makeAlert(title: self.warningTitle, desc: self.warningDesc)
        }
        else {
            makeAlert(title: "Perhatian", desc: "Mohon Isi Nama dan Password")
        }
        
        nameTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    @IBAction func masukMuridBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension LoginViewController {
    func addNewTeacher(name: String, password: String) {
        database?.child(name).observe(.value, with: { snapshot in
            guard (snapshot.value as? [String:Any]) != nil else {
                self.teacher["password"] = password
                self.teacher["latihan"] = [
                    "Judul Latihan": ["Masukkan Judul","Masukkan Pertanyaan", "Masukkan Jawaban Benar", "Masukkan Jawaban Salah", "Masukkan Jawaban Salah", "Masukkan Jawaban Salah"]
                ]
                self.teacher["materi"] = [
                    "Judul Materi": ["Masukkan Judul","Masukkan Isi"]
                ]
                
                self.database?.child("\(name)").setValue(self.teacher)
                self.isLogin = false
                
                self.warningTitle = "Berhasil"
                self.warningDesc = "Silahkan Masuk Dengan Nama dan Password Anda"
                
                return
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.warningTitle = "Gagal"
            self.warningDesc = "Nama Sudah Terdaftar"
        }
    }
    
    func login(name: String, password: String) {
        database?.child(name).observe(.value, with: { snapshot in
            guard let value = snapshot.value as? [String:Any] else {
                self.isLogin = false
                return
            }
            
            if value["password"] as! String != password {
                self.isLogin = false
            }
            else {
                self.isLogin = true
                self.teacher = value
            }
        })
    }
}
