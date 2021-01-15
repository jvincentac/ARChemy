//
//  ViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 02/01/21.
//

import UIKit
import CoreData

    
class ARModeViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var searchZat: UISearchBar!
    
    @IBOutlet weak var ZatTableView: UITableView!
    
    var namaZat : [String] = []
    
    //copy dari vincent
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
    
    // search bar array
    var filteredData : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllElements()
        
        ZatTableView.delegate = self
        ZatTableView.dataSource = self
        ZatTableView.backgroundColor = .white
        
        searchZat.delegate = self
        
        filteredData = namaZat
        
    }
    // MARK : Search Bar Config
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == ""{
            filteredData = namaZat
        }else{
            for zat in namaZat {
                if zat.lowercased().contains(searchText.lowercased()){
                    filteredData.append(zat)
                }
            }
        }
        
        self.ZatTableView.reloadData()
    }
}

extension ARModeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let search = filteredData[indexPath.row]
        getElementDataByName2(elementName: search)
        
        let newElement = ElementModel(atomicMass: atomicMass, discoverer: discoverer, electrons: Int16(numberOfElectrons), group: Int16(group), name: search, neutrons: Int16(numerOfNeutrons), period: Int16(period), symbol: symbol, type: type)
        
        InitViewController.arrayOfElements.append(newElement)
        
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ARView") as! ARView
        present(sb, animated: true, completion: nil)
    }
}


extension ARModeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row]
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        
        return cell
        
    }
}

extension ARModeViewController {
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
    
    func getAllElements(){
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
            elementName = (element.value(forKeyPath: "name") as? String)!
            namaZat.append(elementName)
            elementName = ""
            }
        }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toARPage" {
//            
//        }
//    }
}











