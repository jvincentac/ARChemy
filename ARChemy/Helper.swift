//
//  Helper.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 21/12/20.
//

import Foundation
import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
