//
//  DescriptionViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 05/01/21.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var elementDesc = InitViewController.arrayOfElements
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 115
        tableView.separatorStyle = .none
        
        tableView.register(Description.nib(), forCellReuseIdentifier: Description.identifier)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementDesc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Description.identifier, for: indexPath) as! Description
        
        cell.configure(bgColor: UIColor.black, symbol: elementDesc[indexPath.row].symbol, elementName: elementDesc[indexPath.row].name, group: Int(elementDesc[indexPath.row].group), period: Int(elementDesc[indexPath.row].period), atomicMass: elementDesc[indexPath.row].atomicMass, numberOfElectrons: Int(elementDesc[indexPath.row].electrons), numberOfNeutrons: Int(elementDesc[indexPath.row].neutrons), discoverer: elementDesc[indexPath.row].discoverer, type: elementDesc[indexPath.row].type)
        
        return cell
    }
}
