//
//  CoreDataHelper.swift
//  TikiTool
//
//  Created by ZickOne on 2/27/17.
//  Copyright © 2017 ZickOne. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataHelper {
    
    func Save(box: BoxItem) -> Bool {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext

       let entity = NSEntityDescription.entity(forEntityName: "DeepLink",
                                   in: managedContext)!

        let deepLink = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        deepLink.setValue(box.name, forKeyPath: "name")
        deepLink.setValue(box.link, forKeyPath: "link")

        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    func fetch(entityStr : String) -> [BoxItem] {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return []
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext

        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "DeepLink")
        
        do {
            let rawDeepLinks = try managedContext.fetch(fetchRequest)
            var deepLink = [BoxItem]()
            for item in rawDeepLinks {
              let nameBox =  item.value(forKeyPath: "name") as? String
              let linkBox =  item.value(forKeyPath: "link") as? String
              let box = BoxItem(name:nameBox!,link:linkBox!,false)
                deepLink += [box]
                
            }
            return deepLink
        } catch let error as NSError {
            return []
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func removeDeepLink(box: BoxItem) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        do {
            let managedContext =
                appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DeepLink")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "name == %@ AND link == %@", box.name,box.link)

            var objects: [NSManagedObject]
            try  objects = managedContext.fetch(fetchRequest)  as! [NSManagedObject]
            managedContext.delete(objects.first!)
            try managedContext.save()
        } catch  {
            
        }
    }
}
