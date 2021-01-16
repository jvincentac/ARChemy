//
//  ReaksiTableViewCell.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 16/01/21.
//

import UIKit

class ReaksiTableViewCell: UITableViewCell {

    @IBOutlet weak var reaksiImageView: UIImageView!
    
    static let identifier = "ReaksiTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ReaksiTableViewCell", bundle: nil)
    }
    
    public func configure(image: UIImage) {
        self.reaksiImageView.image = image
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
