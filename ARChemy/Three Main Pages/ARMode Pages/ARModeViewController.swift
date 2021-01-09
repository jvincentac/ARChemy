//
//  ViewController.swift
//  ARchemy
//
//  Created by Yudis Huang on 02/01/21.
//

import UIKit

    
class ARModeViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var searchZat: UISearchBar!
    
    @IBOutlet weak var ZatTableView: UITableView!
    
    var namaZat : [String] = ["Oksigen","Hidrogen","Nitrogen"]
    
    // search bar array
    var filteredData : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ZatTableView.delegate = self
        ZatTableView.dataSource = self
        
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
        print(namaZat[indexPath.row])
    }
}


extension ARModeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ZatTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = filteredData[indexPath.row]
        
        return cell
        
        
    }
    
    
}



