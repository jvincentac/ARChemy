//
//  Material.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import Foundation
import CoreData

class Material: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Material] {
        let request: NSFetchRequest<Material> = Material.fetchRequest()
        
        guard let materials = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return materials
    }
    
    static func fetchMaterialByName(name: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Material] {
        
        let request: NSFetchRequest<Material> = Material.fetchRequest()
        
        request.predicate = NSPredicate(format: "owner.name == %@", name)
        
        guard let materials = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return materials
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        fetchAll(viewContext: viewContext).forEach({
            viewContext.delete($0)
        })
        
        try? viewContext.save()
    }
}
