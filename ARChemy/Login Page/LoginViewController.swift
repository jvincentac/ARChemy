//
//  LoginViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 14/01/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    var NameList : [String] = ["Andi","Dodi"]
    var PassList : [String] = ["abc","123"]
    
    @IBOutlet weak var errorLoginHandler: UILabel!
    
    
    //boolean to check if the ids is available
    var availID : Bool = false
    
    //boolean for login
    var loginValidation : Bool = false
    
    @IBOutlet weak var nameAdmin: UITextField!
    @IBOutlet weak var passwordAdmin: UITextField!
    
    @IBAction func LoginStudent(_ sender: Any) {
        //segue to main 3 tab apps
        print("masuk sebagai siswa")
    }
    
    
    @IBAction func LoginTeacher(_ sender: Any) {
        if(nameAdmin.text == "" ){
            errorLoginHandler.text = "Anda Belum Menginput Nama/Pass"
        }
        
        for i in NameList{
            if(nameAdmin.text == i ){
                for j in PassList {
                    if(passwordAdmin.text == j){
                        loginValidation = true
                    }else{
                        loginValidation = false
                    }
                }
            }else{
                print("Your Name is not registered")
                view.endEditing(true)
            }
        }
    }
    
    
    @IBAction func RegisTeacher(_ sender: Any) {
        for i in NameList{
            if(nameAdmin.text != i){
                NameList.append(nameAdmin.text!)
                PassList.append(passwordAdmin.text!)
                print("Success to register")
            }else{
                print("Current Name has been use try unique one")
            }
        }
    }
    
   
    func configureTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(){
        print("handleTap was called")
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameAdmin.delegate = self
        passwordAdmin.delegate = self
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
