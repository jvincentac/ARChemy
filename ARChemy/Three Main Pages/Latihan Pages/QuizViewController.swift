//
//  QuizViewController.swift
//  ARChemy
//
//  Created by Yudis Huang on 09/01/21.
//

import UIKit

class QuizViewController: UIViewController {
    var question : [String] = ["Berapakah Jumlah Proton dari ","Berapakah jumlah Netron dari "]
    var namazat : [String] = ["Hydrogen","Oxygen","Nitrogen"]
    
    var indexRecord : Int = 0
    var AnswerProton : [String] = ["8","2","1"]
    var AnswerNetron : [String] = ["1","4","5"]
    var correctAnswer : String = ""
    
    
    @IBOutlet weak var LabelQuestion: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    

    var questionChoice : String = ""
    var questionZatName : String = ""
    
//array for 4 labels
    var answer : [String] = ["","","",""]


//shuffle 4 label answer1-4
    var shuffleAnswer : Int = Int.random(in: 0..<4)
    
//temp var for filling correctAnswer value index
    var correctAnswerIndex : Int = 0

// this is for shuffle() for eliminating same numbers
    var number : [Int] = [0,1,2,3,4,5,6,7,8,9]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        correctAnswerIndex = shuffleAnswer
        questionChoice = question.randomElement()!
        questionZatName = namazat.randomElement()!
        
        chooseQuestion()
        shuffle()
 

        
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
        
        print(answer1.text = answer[0])
        print(answer2.text = answer[1])
        print(answer3.text = answer[2])
        print(answer4.text = answer[3])
        
//        number.removeAll()
//        var number : [Int] = [0,1,2,3,4,5,6,7,8,9]
    }
    
    func chooseQuestion(){
        if(questionChoice == "Berapakah Jumlah Proton dari "){
            LabelQuestion.text = "Berapakah Jumlah Proton dari \(questionZatName)"
            
            //taking index and zat name that suit with the questionZatName that we use to ask the users
            for (index, zat) in namazat.enumerated(){
                                if(questionZatName == zat ){
                                    indexRecord = index
                                    print(indexRecord)
                                }
            }
            
            correctAnswer = AnswerProton[indexRecord]
            
            

        }else{
            LabelQuestion.text = "Berapakah Jumlah Netron dari \(questionZatName)"
            
            for (index, zat) in namazat.enumerated(){
                                if(questionZatName == zat ){
                                    indexRecord = index
                                    print(indexRecord)
                                }
            }
            
            correctAnswer = AnswerNetron[indexRecord]
        }
    }
    
//    func getData(){
//        let vc = storyboard?.instantiateInitialViewController(identifier : "test" ) as! ARModeViewController
//    }
    
}
