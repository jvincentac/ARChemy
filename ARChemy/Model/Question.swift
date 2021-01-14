//
//  Question.swift
//  ARChemy
//
//  Created by Vincent Alexander Christian on 14/01/21.
//

import Foundation
import CoreData

class Question: NSManagedObject {
    static func fetchAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Question] {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        
        guard let questions = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return questions
    }
    
    static func fetchQuestionByName(name: String, viewContext: NSManagedObjectContext = AppDelegate.viewContext) -> [Question] {
        
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        
        request.predicate = NSPredicate(format: "owner.name == %@", name)
        
        guard let questions = try? AppDelegate.viewContext.fetch(request) else {
            return []
        }
        
        return questions
    }
    
    static func deleteAllQuestion(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        fetchAll(viewContext: viewContext).forEach({
            viewContext.delete($0)
        })
        
        try? viewContext.save()
    }
}
