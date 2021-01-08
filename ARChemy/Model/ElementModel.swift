//
//  ElementModel.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 08/01/21.
//

import Foundation

class ElementModel {
    var atomicMass = String()
    var discoverer = String()
    var electrons = Int16()
    var group = Int16()
    var name = String()
    var neutrons = Int16()
    var period = Int16()
    var symbol = String()
    var type = String()
    
    init(atomicMass: String, discoverer: String, electrons: Int16, group: Int16, name: String, neutrons: Int16, period: Int16, symbol: String, type: String) {
        self.atomicMass = atomicMass
        self.discoverer = discoverer
        self.electrons = electrons
        self.group = group
        self.name = name
        self.neutrons = neutrons
        self.period = period
        self.symbol = symbol
        self.type = type
    }
}
