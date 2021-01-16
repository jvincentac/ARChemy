//
//  MateriTableViewCell.swift
//  ARchemy
//
//  Created by Yudis Huang on 04/01/21.
//

import UIKit

class MateriTableViewCell: UITableViewCell {
    
    static let identifier = "MateriTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MateriTableViewCell", bundle: nil)
    }
    
    

    @IBOutlet var materiTitle : UILabel!
    
    
    public func configure(with title: String){
        materiTitle.text = title

        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
