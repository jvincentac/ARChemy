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
    
    var teacher: [String: Any] = [:]
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        
    }
    
    @IBAction func loginBtn(_ sender: Any) {
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
                print("wrong name or password")
            }
        }
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        addNewTeacher(name: nameTextField.text!, password: passwordTextField.text!)
    }
    @IBAction func deleteAllTeacherBtn(_ sender: Any) {
        
    }
}

extension LoginViewController {
    func addNewTeacher(name: String, password: String) {
        teacher["password"] = password
        teacher["latihan"] = [
            "Judul": ["Masukkan Judul","Masukkan Pertanyaan", "Masukkan Jawaban Benar", "Masukkan Jawaban Salah", "Masukkan Jawaban Salah", "Masukkan Jawaban Salah"]
        ]
        teacher["materi"] = [
            "Judul": ["Masukkan Judul","Masukkan Isi"]
        ]
        
        database?.child("\(name)").setValue(teacher)
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
