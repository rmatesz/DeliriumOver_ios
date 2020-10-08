//
//  MockNSManagedObjectContext.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 30..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import CoreData
@testable import DeliriumOver

class ManagedObjectContext: NSManagedObjectContext {
    override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        return try super.fetch(request)
    }

    override var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get { return super.persistentStoreCoordinator }
        set { super.persistentStoreCoordinator = newValue }
    }

    override func existingObject(with objectID: NSManagedObjectID) throws -> NSManagedObject {
        return try super.existingObject(with: objectID)
    }

    override func insert(_ object: NSManagedObject) {
        super.insert(object)
    }

    override func delete(_ object: NSManagedObject) {
        super.delete(object)
    }

    override func save() throws {
        try super.save()
    }

    override func obtainPermanentIDs(for objects: [NSManagedObject]) throws {
        try super.obtainPermanentIDs(for: objects)
    }
}

class ManagedObjectID: NSManagedObjectID {
    override func uriRepresentation() -> URL {
        return super.uriRepresentation()
    }
}

class PersistentStoreCoordinator: NSPersistentStoreCoordinator {
    override func managedObjectID(forURIRepresentation url: URL) -> NSManagedObjectID? {
        return super.managedObjectID(forURIRepresentation: url)
    }

    override var managedObjectModel: NSManagedObjectModel {
        get { return super.managedObjectModel }
    }
}

class ManagedObjectModel: NSManagedObjectModel {
    override var entitiesByName: [String : NSEntityDescription] {
        get { return super.entitiesByName }
    }
}

class MConsumptionEntity: ConsumptionEntity {
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    override var objectID: NSManagedObjectID { return super.objectID }

    override var session: SessionEntity? {
        get { return super.session }
        set { super.session = newValue }
    }

    override var drink: String? {
        get { return super.drink }
        set(value) {
            super.drink = value
        }
    }
    override var alcohol: Double  {
        get { return super.alcohol }
        set(value) {
            super.alcohol = value
        }
    }

    override var date: Date?  {
        get { return super.date }
        set(value) {
            super.date = value
        }
    }

    override var quantity: Double  {
        get { return super.quantity }
        set(value) {
            super.quantity = value
        }
    }

    override var unit: Int16  {
        get { return super.unit }
        set(value) {
            super.unit = value
        }
    }
}
