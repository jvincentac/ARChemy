//
//  InitViewController.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 29/11/20.
//
//  intinya ini nanti jadi onboarding, semua yang hanya perlu jalan 1x

import UIKit
import CoreData

class InitViewController: UIViewController {
    
    var arrayOfElement: [ElementModel] = []
    static var arrayOfElements: [ElementModel] = []
    static var reaksiList: [String: UIImage] = [
        "BeCl2" : UIImage(named: "BeCl2")!,
        "BF3" : UIImage(named: "BF3")!,
        "CH3COOH" : UIImage(named: "CH3COOH")!,
        "CH4" : UIImage(named: "CH4")!,
        "CO2" : UIImage(named: "CO2")!,
        "H2O" : UIImage(named: "H2O")!,
        "H2SO4" : UIImage(named: "H2SO4")!,
        "HCl" : UIImage(named: "HCl")!,
        "HNO3" : UIImage(named: "HNO3")!,
        "NaCl" : UIImage(named: "NaCl")!,
        "NaOH" : UIImage(named: "NaOH")!,
        "NH3" : UIImage(named: "NH3")!,
        "SF4" : UIImage(named: "SF4")!,
        "SO2" : UIImage(named: "SO2")!,
        "SO3" : UIImage(named: "SO3")!,
    ]
    
    static var newReaksiList: [String: [Any]] = [
        "BeCl2" : [UIImage(named: "BeCl2")!,"Be","Cl"],
        "BF3" : [UIImage(named: "BF3")!,"B","F"],
        "CH3COOH" : [UIImage(named: "CH3COOH")!,"C","H","O"],
        "CH4" : [UIImage(named: "CH4")!,"C","H"],
        "CO2" : [UIImage(named: "CO2")!,"C","O"],
        "H2O" : [UIImage(named: "H2O")!,"H","O"],
        "H2SO4" : [UIImage(named: "H2SO4")!,"H","S","O"],
        "HCl" : [UIImage(named: "HCl")!,"H","Cl"],
        "HNO3" : [UIImage(named: "HNO3")!,"H","N","O"],
        "NaCl" : [UIImage(named: "NaCl")!,"Na","Cl"],
        "NaOH" : [UIImage(named: "NaOH")!,"Na","O","H"],
        "NH3" : [UIImage(named: "NH3")!,"N","H"],
        "SF4" : [UIImage(named: "SF4")!,"S","F"],
        "SO2" : [UIImage(named: "SO2")!,"S","O"],
        "SO3" : [UIImage(named: "SO3")!,"S","O"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.setValue("Masukkan Nama Guru", forKey: "latihanTeacherName")
        UserDefaults.standard.setValue("Masukkan Nama Guru", forKey: "materiTeacherName")
        if UserDefaults.standard.object(forKey: "isOnboarding") == nil {
            
            print("onboarding")
            
            getAllElement()
            
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Onboarding") as! OnboardingViewController
            
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
            print("login")
            
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
    }
}

extension InitViewController {
    func getAllElement() {
        let url = URL(string: "https://periodic-table-of-elements.p.rapidapi.com/elements")
        
        var dictionary : [Any] = []
        
        var elementName : [String : Any] = [:]
        
        var tempArrayOfElementName = [elementName]
        
        guard url != nil else {
            print("Error creating url")
            return
        }
        
        // URL Request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        // Header
        let header = [
            "x-rapidapi-host": "periodic-table-of-elements.p.rapidapi.com",
            "x-rapidapi-key": "55abd7ff9amsh79437ec708c65bcp1c1d94jsn07a64efaf7b3"
        ]
        request.allHTTPHeaderFields = header
        
        // set request type
        request.httpMethod = "GET"
        
        // get urlsession
        let session = URLSession.shared
        
        // create data task
        let dataTask = session.dataTask(with: request) { [self] (data, response, error) in
            if error == nil && data != nil {
                do {
                    dictionary = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers)) as! [Any]
                    
                    print(dictionary.count)
                    
                    for dict in dictionary {
                        elementName = dict as! [String : Any]
                        tempArrayOfElementName.append(elementName)
                    }
                    
                    for idx in 1..<tempArrayOfElementName.count {
                        let name = String(describing: tempArrayOfElementName[idx]["Element"]!)
                        let discoverer = String(describing: tempArrayOfElementName[idx]["Discoverer"]!)
                        let symbol = String(describing: tempArrayOfElementName[idx]["Symbol"]!)
                        let numberOfElectrons = Int16(String(describing: tempArrayOfElementName[idx]["NumberofElectrons"]!))
                        let numberOfNeutrons = Int16(String(describing: tempArrayOfElementName[idx]["NumberofNeutrons"]!))
                        let atomicMass = String(describing: tempArrayOfElementName[idx]["AtomicMass"]!)
                        let type = String(describing: tempArrayOfElementName[idx]["Type"]!)
                        let group = Int16(String(describing: tempArrayOfElementName[idx]["Group"]!))
                        let period = Int16(String(describing: tempArrayOfElementName[idx]["Period"]!))
                        
                        saveToCoreData(name: name, type: type, symbol: symbol, neutrons: numberOfNeutrons!, electrons: numberOfElectrons!, discoverer: discoverer, atomicMass: atomicMass, group: group ?? 0, period: period ?? 0)
                    }
                    
                } catch {
                    print("Error parsing")
                }
            }
            
        }
        
        // fire off data task
        dataTask.resume()
    }
    
    func saveToCoreData(name: String, type: String, symbol: String, neutrons: Int16, electrons: Int16, discoverer: String, atomicMass: String, group: Int16, period: Int16) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Element", in: managedContext)!
        
        let element = NSManagedObject(entity: entity, insertInto: managedContext)
        
        element.setValue(name, forKey: "name")
        element.setValue(type, forKey: "type")
        element.setValue(symbol, forKey: "symbol")
        element.setValue(neutrons, forKey: "neutrons")
        element.setValue(electrons, forKey: "electrons")
        element.setValue(discoverer, forKey: "discoverer")
        element.setValue(atomicMass, forKey: "atomicMass")
        element.setValue(group, forKey: "group")
        element.setValue(period, forKey: "period")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func saveQuestionToCoreData(question: String, answer: String, w1: String, w2: String, w3: String, w4: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Question", in: managedContext)!
        
        let questions = NSManagedObject(entity: entity, insertInto: managedContext)
        
        questions.setValue(question, forKey: "question")
        questions.setValue(answer, forKey: "answer")
        questions.setValue(w1, forKey: "w1")
        questions.setValue(w2, forKey: "w2")
        questions.setValue(w3, forKey: "w3")
    }
}
