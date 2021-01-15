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
    let kotakBenar = UIImage(named: "kotak benar")
    let kotakSalah = UIImage(named: "kotak salah")
    
//var to check the answer is correct or no with the check button
    var trueorfalse : Bool = false
    
    @IBOutlet weak var trueorfalseImage: UIImageView!
    @IBOutlet weak var checkAnswerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trueorfalseImage.isHidden = true
        correctAnswerIndex = shuffleAnswer
        questionChoice = question.randomElement()!
        questionZatName = namazat.randomElement()!
        
        chooseQuestion()
        shuffle()
        
        configurePage()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func box1Tapped(_ sender: UIButton) {
        checkAnswerButton.isUserInteractionEnabled = true
        box1.setImage(kotakPilih, for: .normal)
        AllEmptyExceptBox1()
        
        box1clicked = true
        box2clicked = false
        box3clicked = false
        box4clicked = false
    }
    
    @IBAction func box2Tapped(_ sender: UIButton) {
        checkAnswerButton.isUserInteractionEnabled = true
        box2.setImage(kotakPilih, for: .normal)
        AllEmptyExceptBox2()
        
        box1clicked = false
        box2clicked = true
        box3clicked = false
        box4clicked = false
    }
    
    @IBAction func box3Tapped(_ sender: UIButton) {
        checkAnswerButton.isUserInteractionEnabled = true
        box3.setImage(kotakPilih, for: .normal)
        AllEmptyExceptBox3()
        
        box1clicked = false
        box2clicked = false
        box3clicked = true
        box4clicked = false
    }
    
    @IBAction func box4Tapped(_ sender: UIButton) {
        checkAnswerButton.isUserInteractionEnabled = true
        box4.setImage(kotakPilih, for: .normal)
        AllEmptyExceptBox4()
        
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
        }else if(box4clicked == true){
            if(answer4.text == correctAnswer){
                trueorfalse = true
            }else{
                trueorfalse = false
            }
        }
        
        if(trueorfalse == true){
            trueorfalseImage.isHidden = false
            trueorfalseImage.image = UIImage(named: "true")
            disableAllBoxButton()
        }else{
            trueorfalseImage.isHidden = false
            trueorfalseImage.image = UIImage(named: "false")
            disableAllBoxButton()
            checkAnswerButton.setTitle("Cek Jawaban", for: .normal)
            
        }
        
        if(checkAnswerButton.titleLabel?.text == "Cek Jawaban"){
            if(correctAnswer == answer[correctAnswerIndex]){
                if(correctAnswerIndex+1 == 1){
                    box1.setImage(kotakBenar, for: .normal)
                    AllEmptyExceptBox1()
                    
                }else if(correctAnswerIndex+1 == 2){
                    box2.setImage(kotakBenar, for: .normal)
                    AllEmptyExceptBox2()
                }else if(correctAnswerIndex+1 == 3){
                    box3.setImage(kotakBenar, for: .normal)
                    AllEmptyExceptBox3()
                }else{
                    box4.setImage(kotakBenar, for: .normal)
                    AllEmptyExceptBox4()
                }
            }
            checkAnswerButton.setTitle("Lanjut", for: .normal)
        }
        else if (checkAnswerButton.titleLabel?.text == "Lanjut") {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
    }
}

extension QuizViewController {
    func configurePage() {
        answer1.textColor = .black
        answer2.textColor = .black
        answer3.textColor = .black
        answer4.textColor = .black
        
        checkAnswerButton.isUserInteractionEnabled = false
    }
    
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
                    
                    }
                }
            }
        }
        
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
    
    func disableAllBoxButton(){
        box1.isEnabled = false
        box2.isEnabled = false
        box3.isEnabled = false
        box4.isEnabled = false
    }
    
    func AllEmptyExceptBox1(){
        box2.setImage(kotakKosong, for: .normal)
        box3.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
    }

    
    func AllEmptyExceptBox2(){
        box3.setImage(kotakKosong, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
    }
    
    
    func AllEmptyExceptBox3(){
        box2.setImage(kotakKosong, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        box4.setImage(kotakKosong, for: .normal)
    }
    
    func AllEmptyExceptBox4(){
        box2.setImage(kotakKosong, for: .normal)
        box1.setImage(kotakKosong, for: .normal)
        box3.setImage(kotakKosong, for: .normal)
    }
    
}
