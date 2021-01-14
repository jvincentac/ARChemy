//
//  NewLatihanViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import UIKit

class NewLatihanViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var w1TextField: UITextField!
    @IBOutlet weak var w2TextField: UITextField!
    @IBOutlet weak var w3TextField: UITextField!
    
    var teacher: Teacher?
    var isEdit: Bool = false
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        back()
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        saveQuestion(teacher: teacher!, title: titleTextField.text!, question: questionTextField.text!, correctAnswer: correctAnswerTextField.text!, w1: w1TextField.text!, w2: w2TextField.text!, w3: w3TextField.text!)
        back()
    }
}

extension NewLatihanViewController {
    func configurePage() {
        titleTextField.text = question?.title
        questionTextField.text = question?.question
        correctAnswerTextField.text = question?.answer
        w1TextField.text = question?.w1
        w2TextField.text = question?.w2
        w3TextField.text = question?.w3
    }
    
    func back() {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AdminHome") as! AdminHomeViewController
        sb.modalTransitionStyle = .coverVertical
        sb.modalPresentationStyle = .fullScreen
        sb.teacher = teacher
        
        present(sb, animated: true, completion: nil)
    }
    
    private func saveQuestion(teacher: Teacher, title: String, question: String, correctAnswer: String ,w1: String, w2: String, w3: String) {
        
        if isEdit {
            self.question?.title = titleTextField.text
            self.question?.question = questionTextField.text
            self.question?.answer = correctAnswerTextField.text
            self.question?.w1 = w1TextField.text
            self.question?.w2 = w2TextField.text
            self.question?.w3 = w3TextField.text
        }
        else {
            let newQuestion = Question(context: AppDelegate.viewContext)
            newQuestion.owner = teacher
            newQuestion.title = title
            newQuestion.question = question
            newQuestion.answer = correctAnswer
            newQuestion.w1 = w1
            newQuestion.w2 = w2
            newQuestion.w3 = w3
        }
        
        try? AppDelegate.viewContext.save()
    }
}
