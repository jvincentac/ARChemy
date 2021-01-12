//
//  DescriptionViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 05/01/21.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var elementDesc = InitViewController.arrayOfElements
    let colorList: [UIColor] = [UIColor.orange, UIColor.green, UIColor.blue, UIColor.systemPink, UIColor.red]
    var tempColorIndex = 0
    var colorIndex = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 115
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        
        tableView.register(Description.nib(), forCellReuseIdentifier: Description.identifier)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        InitViewController.arrayOfElements.removeAll()
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementDesc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Description.identifier, for: indexPath) as! Description
        
        while colorIndex == tempColorIndex {
            tempColorIndex = Int.random(in: 0..<colorList.count)
        }
        
        colorIndex = tempColorIndex
        
        cell.configure(bgColor: colorList[colorIndex], symbol: elementDesc[indexPath.row].symbol, elementName: elementDesc[indexPath.row].name, group: Int(elementDesc[indexPath.row].group), period: Int(elementDesc[indexPath.row].period), atomicMass: elementDesc[indexPath.row].atomicMass, numberOfElectrons: Int(elementDesc[indexPath.row].electrons), numberOfNeutrons: Int(elementDesc[indexPath.row].neutrons), discoverer: elementDesc[indexPath.row].discoverer, type: elementDesc[indexPath.row].type)
        
        return cell
    }
}
