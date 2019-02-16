//
//  DAOImpl.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class DAOImpl : DAO {
    let context: NSManagedObjectContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }

    func save() -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            do {
                try self.context.save()
                observer(CompletableEvent.completed)
            } catch {
                observer(CompletableEvent.error(error))
            }
            return Disposables.create()
        })
    }
    
}
