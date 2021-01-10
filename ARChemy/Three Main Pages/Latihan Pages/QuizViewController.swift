//
//  QuizViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 09/01/21.
//

import UIKit

class QuizViewController: UIViewController {
    var question : [String] = ["Berapakah Jumlah Proton dari ","Berapakah jumlah Netron dari "]
    
    var correctAnswer : String = "8"
    
    
    @IBOutlet weak var LabelQuestion: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    

    
    var answer : [String] = ["","","",""]
//
//    var answer1 : String = String(Int.random(in: 1..<9))
//    var answer2 : String = ""
//    var answer3 : String = ""
//    var answer4 : String = ""
//
    var questionChoice : String = ""
    var shuffleAnswer : Int = Int.random(in: 0..<4)
    var correctAnswerIndex : Int = 0

// this is for shuffle() for eliminating same numbers
    var number : [Int] = [0,1,2,3,4,5,6,7,8,9]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        correctAnswerIndex = shuffleAnswer
        questionChoice = question.randomElement()!
        
        shuffle()
        
        print(answer1.text = answer[0])
        print(answer2.text = answer[1])
        print(answer3.text = answer[2])
        print(answer4.text = answer[3])
        
        
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

extension QuizViewController {
    func shuffle(){
        
        
        for j in number {
            if(Int(correctAnswer) == j){
            number.remove(at: j)
            }
        }

        for i in 0..<4 {
            if(i == correctAnswerIndex ){
                answer[i] = correctAnswer
                                
            }else{
                answer[i] = String(number.randomElement()!)
                
//                for j in number {
//                    if(Int(answer[i]) == j){
//                    number.remove(at: j)
//                    }
//                }
                
            }
        }
//        number.removeAll()
//        var number : [Int] = [0,1,2,3,4,5,6,7,8,9]
    }
    
    func chooseQuestion(){
        if(questionChoice == "Berapakah Jumlah Proton dari "){
            
        }
    }
}
