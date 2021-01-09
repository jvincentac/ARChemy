//
//  LatihanTableViewCell.swift
//  ARchemy
//
//  Created by Yudis Huang on 04/01/21.
//

import UIKit

class LatihanTableViewCell: UITableViewCell {
    
    static let identifier = "LatihanTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "LatihanTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, imageName: String){
        latihanTitle.text = title
        latihanImage.image = UIImage(named: imageName)
        
    }
    
    @IBOutlet var latihanTitle : UILabel!
    @IBOutlet var latihanImage : UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
