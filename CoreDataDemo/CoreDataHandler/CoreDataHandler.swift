//
//  CoreDataHandler.swift
//  CoreDataDemo
//
//  Created by Falguni Viral Chauhan on 06/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {
    
     private class func getContext() -> NSManagedObjectContext {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.persistentContainer.viewContext
    }
    
    class func saveData(name: String, ceo: String) -> Bool {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Company", in: context) else { return false }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(name, forKey: "name")
        managedObject.setValue(ceo, forKey: "ceo")
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    class func fetchData() -> [Company]? {
        let context = getContext()
        var users: [Company]?
        do {
            users = try context.fetch(Company.fetchRequest())
            return users
        } catch {
            return users
        }
    }
    
    class func deleteData(company: Company) -> Bool {
        let context = getContext()
        context.delete(company)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func cleanData() -> Bool {
        let context = getContext()
        let deleteReq = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        do {
            try context.execute(deleteReq)
            return true
        } catch {
            return false
        }
    }
    
    class func fliterData(searchingString: String) -> [Company]? {
        let context = getContext()
        let fetchRequest: NSFetchRequest = Company.fetchRequest()
        var users: [Company]?
        
        fetchRequest.predicate = NSPredicate(format: "name contains[c] %@", searchingString)
        do {
            users = try context.fetch(fetchRequest)
            return users
        } catch {
            return users
        }
    }
    
    class func updateData(aCompany: Company, newName: String, newCeo: String)-> Bool {
        if let company = getById(id: aCompany.objectID) {
            let context = getContext()
            company.name = newName
            company.ceo = newCeo
            
            do {
                try context.save()
                return true
            }catch {
                return false
            }
        }
        return false
        
    }
    
     class func getById(id: NSManagedObjectID) -> Company? {
        return getContext().object(with: id) as? Company
    }
    
}
