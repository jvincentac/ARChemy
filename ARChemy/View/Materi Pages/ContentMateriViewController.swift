//
//  ContentMateriViewController.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 15/01/21.
//

import UIKit

class ContentMateriViewController: UIViewController {

    @IBOutlet weak var titleTextField: UILabel!
    @IBOutlet weak var materiTextField: UITextView!
    
    private var judul = ""
    private var konten = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePage()
    }
    
    @IBAction func backBtn(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitTab") as! TabBarViewController
        sb.idx = 2
        
        sb.modalPresentationStyle = .fullScreen
        
        present(sb, animated: true, completion: nil)
    }
}

extension ContentMateriViewController {
    func configurePage() {
        titleTextField.text = judul
        materiTextField.text = konten
        materiTextField.isUserInteractionEnabled = false
        titleTextField.isUserInteractionEnabled = false
        materiTextField.backgroundColor = .white
        materiTextField.tintColor = .white
    }
    
    public func setJudul(judul: String) {
        self.judul = judul
    }
    
    public func setKonten(konten:String) {
        self.konten = konten
    }
}
