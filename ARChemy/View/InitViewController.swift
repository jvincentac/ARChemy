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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllElement()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UserDefaults.standard.setValue("Masukkan Nama Guru", forKey: "latihanTeacherName")
        UserDefaults.standard.setValue("Masukkan Nama Guru", forKey: "materiTeacherName")
        if UserDefaults.standard.object(forKey: "isOnboarding") == nil {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Onboarding") as! OnboardingViewController
            
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! LoginViewController
            
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
                    
                    for dict in dictionary {
                        elementName = dict as! [String : Any]
                        tempArrayOfElementName.append(elementName)
                    }
                    
                    var temp = [String]()
                    
                    for idx in 1..<tempArrayOfElementName.count {
                        temp.append(String(describing: tempArrayOfElementName[idx]["Element"]!))
                        
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
                    
                    UserDefaults.standard.setValue(temp, forKey: "elementName")
                    
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
