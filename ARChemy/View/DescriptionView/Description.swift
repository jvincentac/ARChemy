//
//  Description.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 12/01/21.
//

import UIKit

class Description: UITableViewCell {

    @IBOutlet weak var elementBackground: UIView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var elementNameLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var atomicMassLabel: UILabel!
    @IBOutlet weak var numberOfElectronsLabel: UILabel!
    @IBOutlet weak var numberOfNeutronsLabel: UILabel!
    @IBOutlet weak var discovererLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    static let identifier = "descriptionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "Description", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        elementBackground.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(bgColor:UIColor, symbol: String, elementName: String, group: Int, period: Int, atomicMass: String, numberOfElectrons: Int, numberOfNeutrons: Int, discoverer: String, type: String) {
        elementBackground.backgroundColor = bgColor
        symbolLabel.text = symbol
        elementNameLabel.text = elementName
        groupLabel.text = String(group)
        periodLabel.text = String(period)
        atomicMassLabel.text = atomicMass
        numberOfElectronsLabel.text = String(numberOfElectrons)
        numberOfNeutronsLabel.text = String(numberOfNeutrons)
        discovererLabel.text = discoverer
        typeLabel.text = type
    }
    
}
