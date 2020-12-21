//
//  AllElementViewController.swift
//  ARKit_1
//
//  Created by Vincent Alexander Christian on 27/10/20.
//

import UIKit
import CoreData

class AllElementViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allElementNameList : [String] = []
    
    var elements: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        allElementNameList = UserDefaults.standard.object(forKey: "elementName") as! [String]

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchFromCoreData()
    }
}

extension AllElementViewController {
    func fetchFromCoreData() {
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
            allElementNameList.append(element.value(forKeyPath: "name") as? String ?? "nil")
        }
    }
}

extension AllElementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as! Home
        sb.modalPresentationStyle = .fullScreen
        sb.elementName = allElementNameList[indexPath.row]
        present(sb, animated: true, completion: nil)
    }
}

extension AllElementViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allElementNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = allElementNameList[indexPath.row]
        
        return cell
    }
}
