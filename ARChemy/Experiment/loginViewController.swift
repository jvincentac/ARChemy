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

    @IBOutlet weak var teacherTableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var teacherList: [Teacher] = Teacher.fetchAll()
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isLogin == true{
                print("login success")
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

extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teacherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TeacherCell")
        
        return cell
    }
}

extension LoginViewController {
    func addNewTeacher(name: String, password: String) {
        teacher["password"] = password
        teacher["latihan"] = [""]
        teacher["materi"] = [""]
        
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
            }
        })
    }
}
