//
//  QuizzViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 15/01/21.
//

import UIKit

class QuizzViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    var question = ""
    var correctAnswer = ""
    var w1 = ""
    var w2 = ""
    var w3 = ""
    
    var choosenAnswer = ""
    var choosenButton: UIButton?
    var buttonArr: [UIButton] = []
    var answers: [String] = []
    var temp: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonArr.append(answer1)
        buttonArr.append(answer2)
        buttonArr.append(answer3)
        buttonArr.append(answer4)

        answers.append(correctAnswer)
        answers.append(w1)
        answers.append(w2)
        answers.append(w3)
        
        configurePage()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
    }
    
    @IBAction func checkBtn(_ sender: Any) {
        checkAnswer()
    }
    
    @IBAction func answer1Btn(_ sender: Any) {
        choosenAnswer = answer1.title(for: .normal)!
        choosenButton = answer1
        greenBorder(button: answer1)
        clearBorder(button: answer2)
        clearBorder(button: answer3)
        clearBorder(button: answer4)
    }
    
    @IBAction func answer2Btn(_ sender: Any) {
        choosenAnswer = answer2.title(for: .normal)!
        choosenButton = answer2
        greenBorder(button: answer2)
        clearBorder(button: answer1)
        clearBorder(button: answer3)
        clearBorder(button: answer4)
    }
    
    @IBAction func answer3Btn(_ sender: Any) {
        choosenAnswer = answer3.title(for: .normal)!
        choosenButton = answer3
        greenBorder(button: answer3)
        clearBorder(button: answer2)
        clearBorder(button: answer1)
        clearBorder(button: answer4)
    }
    
    @IBAction func answer4Btn(_ sender: Any) {
        choosenAnswer = answer4.title(for: .normal)!
        choosenButton = answer4
        greenBorder(button: answer4)
        clearBorder(button: answer1)
        clearBorder(button: answer3)
        clearBorder(button: answer2)
    }
}

extension QuizzViewController {
    func configurePage() {
        questionLabel.text = question
        var random = 0

        for button in buttonArr {
            random = Int.random(in: 0..<4)
            button.setTitle(answers[random], for: .normal)
        }
    }
    
    func checkAnswer() {
        if choosenAnswer == correctAnswer {
            
        }
        else {
            redBorder(button: choosenButton!)
        }
    }
    
    func clearBorder(button: UIButton) {
        button.layer.borderWidth = 0
    }
    
    func greenBorder(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 0, green: 255, blue: 0, alpha: 1)
    }
    
    func redBorder(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 255, green: 0, blue: 0, alpha: 1)
    }
}
