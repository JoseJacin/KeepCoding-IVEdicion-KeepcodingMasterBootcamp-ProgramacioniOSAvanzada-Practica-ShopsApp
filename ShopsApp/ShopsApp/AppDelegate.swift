//
//  AppDelegate.swift
//  ShopsApp
//
//  Created by Jose Sanchez Rodriguez on 8/5/17.
//  Copyright © 2017 Jose Sanchez Rodriguez. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var context: NSManagedObjectContext?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        func loadingViewController(){
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loadController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainController")
            
            self.window?.rootViewController = loadController
        }
        
        // Override point for customization after application launch.
        
        // Persistent Container
        let container = persistentContainer(dbName: Constants.dbName) { (error: NSError) in
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
        
        self.context = container.viewContext
        
        //NOTE: This command is used to see where the sqlite file is and to open the CoreData BDD with a specialized app, such as Datum
        //print(container.persistentStoreDescriptions.first?.url ?? "")
        
        guard (loadJSONFromSandBox(context: context!)) else {
            fatalError("Error download or parson JSON")
        }
        
        injectContextToFirstViewController()
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        guard let context = self.context else {
            return
        }
        saveContext(context: context)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        guard let context = self.context else {
            return
        }
        saveContext(context: context)
    }
    
    
    func injectContextToFirstViewController() {
        if let navController = window?.rootViewController as? UINavigationController,
            let initialViewController = navController.topViewController as? ShopsViewController {
            initialViewController.context = self.context
        }
    }
}

