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
    
    var newReaksiList: [String: [String]] = InitViewController.newReaksiList
    var imageList: [UIImage] = []
    
    @IBOutlet weak var reaksiTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 115
        tableView.separatorStyle = .none
        
        reaksiTableView.dataSource = self
        reaksiTableView.separatorStyle = .none
        
        tableView.register(Description.nib(), forCellReuseIdentifier: Description.identifier)
        
        reaksiTableView.register(ReaksiTableViewCell.nib(), forCellReuseIdentifier: ReaksiTableViewCell.identifier)
        
        reaksiTableView.rowHeight = 170
        
        print(reaksiTableView.rowHeight)
        
//        checkForReaction(userInput: elementDesc.count)
        checkForReaction2()
    }
    
    @IBAction func doneBtn(_ sender: Any) {
        InitViewController.arrayOfElements.removeAll()
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab")
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}

extension DescriptionViewController {
    
    func checkForReaction2() {
        var userInput: [String] = []
        let arr = Array(newReaksiList.keys)
        
        for ele in elementDesc {
            userInput.append(ele.symbol)
        }
        
        if elementDesc.count == 1 {
            for name in arr {
                if newReaksiList[name]!.contains(userInput[0]) {
                    imageList.append(UIImage(named: newReaksiList[name]![0])!)
                }
            }
        }
        else if elementDesc.count == 2 {
            for name in arr {
                if newReaksiList[name]!.contains(userInput[0]) && newReaksiList[name]!.contains(userInput[1]) {
                    imageList.append(UIImage(named: newReaksiList[name]![0])!)
                }
            }
        }
        else if elementDesc.count == 3 {
            for name in arr {
                if newReaksiList[name]!.contains(userInput[0]) && newReaksiList[name]!.contains(userInput[1]) && newReaksiList[name]!.contains(userInput[2]) {
                    imageList.append(UIImage(named: newReaksiList[name]![0])!)
                }
            }
        }
        else if elementDesc.count == 4 {
            for name in arr {
                if newReaksiList[name]!.contains(userInput[0]) && newReaksiList[name]!.contains(userInput[1]) && newReaksiList[name]!.contains(userInput[2]) && newReaksiList[name]!.contains(userInput[3]) {
                    imageList.append(UIImage(named: newReaksiList[name]![0])!)
                }
            }
        }
        else if elementDesc.count == 5 {
            for name in arr {
                if newReaksiList[name]!.contains(userInput[0]) && newReaksiList[name]!.contains(userInput[1]) && newReaksiList[name]!.contains(userInput[2]) && newReaksiList[name]!.contains(userInput[3]) && newReaksiList[name]!.contains(userInput[4]) {
                    imageList.append(UIImage(named: newReaksiList[name]![0])!)
                }
            }
        }
    }
}

extension DescriptionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return elementDesc.count
        }
        else {
            return imageList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: Description.identifier, for: indexPath) as! Description
            
            while colorIndex == tempColorIndex {
                tempColorIndex = Int.random(in: 0..<colorList.count)
            }
            
            colorIndex = tempColorIndex
            
            cell.backgroundColor = .white
            
            cell.configure(bgColor: colorList[colorIndex], symbol: elementDesc[indexPath.row].symbol, elementName: elementDesc[indexPath.row].name, group: Int(elementDesc[indexPath.row].group), period: Int(elementDesc[indexPath.row].period), atomicMass: elementDesc[indexPath.row].atomicMass, numberOfElectrons: Int(elementDesc[indexPath.row].electrons), numberOfNeutrons: Int(elementDesc[indexPath.row].neutrons), discoverer: elementDesc[indexPath.row].discoverer, type: elementDesc[indexPath.row].type)
            
            return cell
        }
        else {
            let cell = reaksiTableView.dequeueReusableCell(withIdentifier: ReaksiTableViewCell.identifier, for: indexPath) as! ReaksiTableViewCell
            
            cell.configure(image: imageList[indexPath.row])
            
            return cell
        }
    }
}
