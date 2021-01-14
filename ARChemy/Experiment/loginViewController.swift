//
//  loginViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var teacherTableView: UITableView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var teacherList: [Teacher] = Teacher.fetchAll()
    var name = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        checkData()
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        addNewTeacher()
    }
    @IBAction func deleteAllTeacherBtn(_ sender: Any) {
        Teacher.deleteAllTeacher()
        teacherList = Teacher.fetchAll()
        teacherTableView.reloadData()
        
        Question.deleteAllQuestion()
        Material.deleteAll()
        
    }
}

extension LoginViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teacherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TeacherCell")
        
        cell.textLabel?.text = "\(teacherList[indexPath.row].name ?? ""), password = \(teacherList[indexPath.row].password ?? "")"
        
        return cell
    }
}

extension LoginViewController {
    private func checkData() {
        self.name = nameTextField.text!
        self.password = passwordTextField.text!
        
        let isExist: [Teacher] = Teacher.fetchAndCheck(viewContext: AppDelegate.viewContext, name: name, password: password)
        
        if isExist.isEmpty {
            print("No Data")
        }
        else {
            print("Success")
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
            sb.teacher = isExist.first
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
    }
    
    private func addNewTeacher() {
        self.name = nameTextField.text!
        self.password = passwordTextField.text!
        saveTeacher(name: name, password: password)
        teacherList = Teacher.fetchAll()
        teacherTableView.reloadData()
        nameTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func saveTeacher(name: String, password: String) {
        let teacher = Teacher(context: AppDelegate.viewContext)
        teacher.name = name
        teacher.password = password
        
        try? AppDelegate.viewContext.save()
    }
}
