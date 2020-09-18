//
//  LoggingSwinject.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 09..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import CoreData
import Foundation
import Swinject

class LoggingSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(LogRepository.self) { (resolver) -> LogRepository in
            LogRepositoryImpl(context: resolver.resolve(NSManagedObjectContext.self, name: CoreDataSwinject.logDataModelContainerName)!)
        }

        defaultContainer.register(RemoteLogger.self) { (resolver) -> RemoteLogger in
            RemoteLogger(repository: resolver.resolve(LogRepository.self)!)
        }

        defaultContainer.register(SumoUploader.self)  { (resolver) -> SumoUploader in
            SumoUploader()
        }
    }
}
