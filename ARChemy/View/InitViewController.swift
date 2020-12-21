//
//  InitViewController.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 29/11/20.
//

import UIKit
import CoreData

class InitViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllElement()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! Home
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
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
                        let numberOfProtons = Int16(String(describing: tempArrayOfElementName[idx]["NumberofProtons"]!))
                        
                        saveToCoreData(name: name, discoverer: discoverer, symbol: symbol, numberOfElectrons: numberOfElectrons!, numberOfProtons: numberOfProtons!)
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
    
    func saveToCoreData(name: String, discoverer: String, symbol: String, numberOfElectrons: Int16, numberOfProtons: Int16) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Element", in: managedContext)!
        
        let element = NSManagedObject(entity: entity, insertInto: managedContext)
        
        element.setValue(name, forKey: "name")
        element.setValue(discoverer, forKey: "discoverer")
        element.setValue(symbol, forKey: "symbol")
        element.setValue(numberOfElectrons, forKey: "electrons")
        element.setValue(numberOfProtons, forKey: "protons")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
