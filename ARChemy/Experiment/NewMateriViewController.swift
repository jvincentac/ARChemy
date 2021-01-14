//
//  NewMateriViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit

class NewMateriViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var materialTextField: UITextView!
    
    var teacher: Teacher?
    var material: Material?
    var isEdit: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit {
            configurePage()
        }
        else {
            titleTextField.clearsOnBeginEditing = true
            materialTextField.clearsOnInsertion = true
        }
    }
    
    @IBAction func CancelBtn(_ sender: Any) {
        back()
    }
    
    @IBAction func SaveBtn(_ sender: Any) {
        saveMaterial(teacher: teacher!, title: titleTextField.text!, material: materialTextField.text!)
        back()
    }
}

extension NewMateriViewController {
    func configurePage() {
        titleTextField.text = material?.title
        materialTextField.text = material?.material
    }
    
    func back() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
        
        sb.modalPresentationStyle = .fullScreen
        sb.modalTransitionStyle = .coverVertical
        sb.teacher = teacher
        
        present(sb, animated: true, completion: nil)
    }
    
    private func saveMaterial(teacher: Teacher, title: String, material: String) {
        
        if isEdit {
            self.material?.title = self.titleTextField.text!
            self.material?.material = self.materialTextField.text!
        }
        else {
            let newMaterial = Material(context: AppDelegate.viewContext)
            
            newMaterial.owner = teacher
            newMaterial.title = title
            newMaterial.material = material
        }
        
        try? AppDelegate.viewContext.save()
    }
}
