//
//  CodeDataAdapter.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

protocol CoreDataAdapter {
    func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject>
}

class CoreDataAdapterImpl: CoreDataAdapter {
    func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject> {
        return Single<NSManagedObject>.create { (observer) -> Disposable in
            DispatchQueue.main.async {
                let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
                observer(SingleEvent.success(entity))
            }
            return Disposables.create()
        }
    }
}
