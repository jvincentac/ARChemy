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
    
    //label in the box 1,2,3,4
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    
    //button in the box 1,2,3,4

    @IBOutlet weak var box1: UIButton!
    @IBOutlet weak var box2: UIButton!
    @IBOutlet weak var box3: UIButton!
    @IBOutlet weak var box4: UIButton!
    
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

// var boolean for checking isClick or no on the button
    var box1clicked : Bool = false
    var box2clicked : Bool = false
    var box3clicked : Bool = false
    var box4clicked : Bool = false
    
    var boxClicked : [Bool] = [false,true]
    let kotakKosong = UIImage(named: "kotak polos")
    let kotakPilih = UIImage(named: "kotak pilihan")

//var to check the answer is correct or no with the check button
    var trueorfalse : Bool = false
    
    @IBOutlet weak var checkAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        correctAnswerIndex = shuffleAnswer
        questionChoice = question.randomElement()!
        questionZatName = namazat.randomElement()!
        
        chooseQuestion()
        shuffle()
 
        
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func box1Tapped(_ sender: UIButton) {
        box1.setImage(kotakPilih, for: .normal)
        box2.setImage(kotakKosong, for: .normal)
        box3.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
        
        box1clicked = true
        box2clicked = false
        box3clicked = false
        box4clicked = false
    }
    
    @IBAction func box2Tapped(_ sender: UIButton) {
        box2.setImage(kotakPilih, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        box3.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
        
        box1clicked = false
        box2clicked = true
        box3clicked = false
        box4clicked = false
    }
    
    @IBAction func box3Tapped(_ sender: UIButton) {
        box3.setImage(kotakPilih, for: .normal)
        box2.setImage(kotakKosong, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
        
        box1clicked = false
        box2clicked = false
        box3clicked = true
        box4clicked = false
    }
    
    @IBAction func box4Tapped(_ sender: UIButton) {
        box4.setImage(kotakPilih, for: .normal)
        box2.setImage(kotakKosong, for: .normal)
        box3.setImage(kotakKosong, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        
        box1clicked = false
        box2clicked = false
        box3clicked = false
        box4clicked = true
    }
    
    @IBAction func checkAnswerAction(_ sender: UIButton) {
        if(box1clicked == true){
            if(answer1.text == correctAnswer){
                trueorfalse = true
            }else{
                trueorfalse = false
            }
        }else if(box2clicked == true){
            if(answer2.text == correctAnswer){
                trueorfalse = true
            }else{
                trueorfalse = false
            }
        }else if(box3clicked == true){
            if(answer3.text == correctAnswer){
                trueorfalse = true
            }else{
                trueorfalse = false
            }
        }else{
            if(answer4.text == correctAnswer){
                trueorfalse = true
            }else{
                trueorfalse = false
            }
        }
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
        
        for (index , j) in number.enumerated(){
            if(Int(correctAnswer) == j){
            number.remove(at: index)
            }
        }

        for i in 0..<4 {
            if(i == correctAnswerIndex ){
                answer[i] = correctAnswer
            }else{
                answer[i] = String(number.randomElement()!)
                
                for (index , j) in number.enumerated(){
                    if(Int(answer[i]) == j){
                    number.remove(at: index)
                    print(number)
                    }
                }
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
    
    func changeTheBox(){
        
    }
    
//    func getData(){
//        let vc = storyboard?.instantiateInitialViewController(identifier : "test" ) as! ARModeViewController
//    }
    
}
