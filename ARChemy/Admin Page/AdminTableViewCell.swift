//
//  AdminTableViewCell.swift
//  ARChemy
//
//  Created by Yudis Huang on 14/01/21.
//

import UIKit

class AdminTableViewCell: UITableViewCell {
    
    static let identifier = "AdminTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AdminTableViewCell", bundle: nil)
    }
    
    
    @IBOutlet var adminImage : UIImageView!
    @IBOutlet var adminTitle : UILabel!
    
    
    public func configure(with title: String, imageName: String){
        adminTitle.text = title
        adminImage.image = UIImage(named: imageName)
        
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
