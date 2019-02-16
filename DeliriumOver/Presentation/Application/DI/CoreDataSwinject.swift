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
    class func setup(defaultContainer: Container) {
        defaultContainer.register(NSManagedObjectContext.self) { (resolver) -> NSManagedObjectContext in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }

        defaultContainer.register(SessionDAO.self) { (resolver) -> SessionDAO in
            SessionDAOImpl(context: resolver.resolve(NSManagedObjectContext.self)!)
        }
        
        defaultContainer.register(ConsumptionDAO.self) { (resolver) -> ConsumptionDAO in
            ConsumptionDAOImpl(context: resolver.resolve(NSManagedObjectContext.self)!)
        }
    }
}
