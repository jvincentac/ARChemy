//
//  Teacher.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import Foundation
import CoreData

class Teacher: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Teacher] {
        let request: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        guard let teachers = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return teachers
    }
    
    static func fetchOne(viewContext: NSManagedObjectContext = AppDelegate.viewContext, name: String) -> [Teacher] {
        let request: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        
        request.predicate = NSPredicate(format: "name == %@", name)
        
        guard let teacher = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return teacher
    }
    
    static func fetchAndCheck(viewContext: NSManagedObjectContext = AppDelegate.viewContext, name: String, password: String) -> [Teacher] {
        let request: NSFetchRequest<Teacher> = Teacher.fetchRequest()
        
        request.predicate = NSPredicate(format: "name == %@ AND password == %@", name, password)
        
        guard let teachers = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        return teachers
    }
    
    static func deleteAllTeacher(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        fetchAll(viewContext: viewContext).forEach({
            viewContext.delete($0)
        })
        
        try? viewContext.save()
    }
}
