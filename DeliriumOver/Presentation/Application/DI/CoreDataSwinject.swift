//
//  CoreDataSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject
import CoreData
import UIKit

class CoreDataSwinject {
    static let deliriumOverContainerName = "DeliriumOver"
    static let logDataModelContainerName = "LogDataModel"

    private static var deliriumOverContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: deliriumOverContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private static var logDataModelContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: logDataModelContainerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
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
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    class func setup(defaultContainer: Container) {
        defaultContainer.register(NSPersistentContainer.self, name: deliriumOverContainerName) { (resolver) -> NSPersistentContainer in
            return deliriumOverContainer
        }

        defaultContainer.register(NSPersistentContainer.self, name: logDataModelContainerName) { (resolver) -> NSPersistentContainer in
            return logDataModelContainer
        }

        defaultContainer.register(NSManagedObjectContext.self, name: deliriumOverContainerName) { (resolver) -> NSManagedObjectContext in
            return resolver.resolve(NSPersistentContainer.self, name: deliriumOverContainerName)!.viewContext
        }

        defaultContainer.register(NSManagedObjectContext.self, name: logDataModelContainerName) { (resolver) -> NSManagedObjectContext in
            return resolver.resolve(NSPersistentContainer.self, name: logDataModelContainerName)!.viewContext
        }

        defaultContainer.register(SessionDAO.self) { (resolver) -> SessionDAO in
            SessionDAOImpl(context: resolver.resolve(NSManagedObjectContext.self, name: deliriumOverContainerName)!)
        }
        
        defaultContainer.register(ConsumptionDAO.self) { (resolver) -> ConsumptionDAO in
            ConsumptionDAOImpl(context: resolver.resolve(NSManagedObjectContext.self, name: deliriumOverContainerName)!)
        }
    }
}
