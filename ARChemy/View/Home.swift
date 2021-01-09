//
//  home.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 25/10/20.
//
//test

import Foundation
import UIKit
import CoreData

class Home: UIViewController {
    
    @IBOutlet weak var labelElementName: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var labelElementInfo: UILabel!
    @IBOutlet weak var toARBtn: UIButton!
    @IBOutlet weak var allElementBtn: UIButton!
    
    var elementName = ""
    var elementDictionary: [String:Any] = [:]
    
    var elements: [NSManagedObject] = []
    
    var discoverer: String = ""
    var symbol: String = ""
    var numberOfElectrons: Int = 0
    var numerOfNeutrons: Int = 0
    var atomicMass: String = ""
    var group: Int = 0
    var period: Int = 0
    var type: String = ""
    
    override func viewDidLoad() {
        setupPage()
    }
    
    @IBAction func searchButton(_ sender: Any) {
        elementName = labelElementName.text!
        elementName = elementName.capitalizingFirstLetter()
        getElementDataByName2(elementName: elementName)
        
        self.showLabel(label: self.labelElementInfo)
        
        self.labelElementInfo.text = "\(self.elementName) \nDiscoverer: \(self.discoverer) \nNumber of Electrons: \(self.numberOfElectrons) \nNumber of Neutrons: \(self.numerOfNeutrons) \nSymbol: \(self.symbol) \nGroup: \(self.group) \nPeriod: \(self.period) \nAtomic Mass: \(self.atomicMass) \nType: \(self.type)"
        
        if !(self.labelElementInfo.text?.contains("Not"))! {
            self.toARBtn.isHidden = false
        }
    }
    
    @IBAction func toARButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARView") as! ARView
        sb.modalPresentationStyle = .fullScreen
        sb.text = self.labelElementInfo.text ?? ""
        present(sb, animated: true, completion: nil)
    }
    
    @IBAction func toAllElementButton(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ElementDesc") as! DescriptionViewController
//        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension Home {
    func setupPage() {
        hideLabel(label: labelElementInfo)
        labelElementInfo.numberOfLines = 0
        searchBtn.setTitle("Search Element", for: .normal)
        toARBtn.setTitle("See in Augmented Reality", for: .normal)
        toARBtn.isHidden = true
        self.hideKeyboardWhenTappedAround()
        allElementBtn.setTitle("All Element", for: .normal)
        labelElementName.text = elementName
    }
    
    func hideLabel(label: UILabel) {
        label.isHidden = true
    }
    
    func showLabel(label: UILabel) {
        label.isHidden = false
    }
    
    func getElementDataByName2(elementName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Element")
        
        do {
            elements = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for element in elements {
            if elementName == element.value(forKeyPath: "name") as? String ?? "nil" {
                self.discoverer = element.value(forKeyPath: "discoverer") as! String
                self.symbol = element.value(forKeyPath: "symbol") as! String
                self.numberOfElectrons = element.value(forKeyPath: "electrons") as! Int
                self.numerOfNeutrons = element.value(forKeyPath: "neutrons") as! Int
                self.type = element.value(forKeyPath: "type") as! String
                self.group = element.value(forKeyPath: "group") as! Int
                self.period = element.value(forKeyPath: "period") as! Int
                self.atomicMass = element.value(forKeyPath: "atomicMass") as! String
                break
            }
            else {
                self.discoverer = "Not Found"
                self.symbol = "Not Found"
                self.numerOfNeutrons = 0
                self.numberOfElectrons = 0
            }
        }
    }
    
    func getElementDataByName(elementName: String) { //sementara belum dipakai
        let url = URL(string: "https://periodic-table-of-elements.p.rapidapi.com/element/name/\(elementName)")
        
        var dictionary : [String : Any] = [:]
        
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
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil && data != nil {
                do {
                    dictionary = try (JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any])!
                    self.elementDictionary = dictionary
                } catch {
                    print("Error parsing")
                }
            }
        }
        
        // fire off data task
        dataTask.resume()
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
