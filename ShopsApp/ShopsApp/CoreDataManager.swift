//
//  CoreDataManager.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import CoreData

// MARK: - Core Data stack
public func persistentContainer(dbName: String, onError: ((NSError) -> Void)? = nil ) -> NSPersistentContainer {
    /*
     The persistent container for the application. This implementation
     creates and returns a container, having loaded the store for the
     application to it. This property is optional since there are legitimate
     error conditions that could cause the creation of the store to fail.
     */
    // Se crea un contenedor (BBDD) con el nombre indicado
    let container = NSPersistentContainer(name: dbName)
    // Se carga en memoria todo el contexto y se configura la BBDD según el contexto. Retorna si ha habido algún error
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error as NSError?,
            let onError = onError {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            
            /*
             Typical reasons for an error here include:
             * The parent directory does not exist, cannot be created, or disallows writing.
             * The persistent store is not accessible, due to permissions or data protection when the device is locked.
             * The device is out of space.
             * The store could not be migrated to the current model version.
             Check the error message to determine what the actual problem was.
             */
            
            //fatalError("Unresolved error \(error), \(error.userInfo)")
            onError(error)
        }
    })
    return container
}

// MARK: - Core Data Saving support
public func saveContext (context: NSManagedObjectContext) {
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
