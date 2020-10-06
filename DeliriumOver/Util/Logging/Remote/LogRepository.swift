//
//  LogRepository.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 08..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

protocol LogRepository {
    func store(model: LogModel) -> Completable
    var logs: Observable<[LogModel]> { get }
    func clear() -> Completable
}

class LogRepositoryImpl: LogRepository {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let context: NSManagedObjectContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func store(model: LogModel) -> Completable {
        return Completable.from {
            let logEntity = NSEntityDescription.insertNewObject(forEntityName: "LogEntity", into: self.context) as! LogEntity
            
            logEntity.data = String(data: try self.encoder.encode(model), encoding: .utf8)!
            logEntity.timestamp = model.timestamp
            
            try self.context.obtainPermanentIDs(for: [logEntity])
            try self.context.save()
        }
    }
    
    var logs: Observable<[LogModel]> {
        return Observable<[LogModel]>.create { (observer) -> Disposable in
            do {
                observer.onNext(try self.getAllSync())
            } catch {
                observer.onError(error)
            }
            
            let contextObserver = { (notification: Notification) in
                do {
                    let result = try self.context.registeredObjects.filter {
                        $0 is LogEntity
                    }.map { $0 as! LogEntity }
                    .map {
                        try self.decoder.decode(LogModel.self, from: $0.data!.data(using: .utf8)!)
                    }
                    observer.onNext(result)
                } catch {
                    observer.onError(error)
                }
            }
            
            let contextObjectsDidChangeObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextObjectsDidChange, object: nil, queue: OperationQueue.current, using: contextObserver)
            let contextObjectsDidSaveObserver = NotificationCenter.default.addObserver(forName: Notification.Name.NSManagedObjectContextDidSave, object: nil, queue: OperationQueue.current, using: contextObserver)
            return Disposables.create {
                NotificationCenter.default.removeObserver(contextObjectsDidChangeObserver)
                NotificationCenter.default.removeObserver(contextObjectsDidSaveObserver)
            }
        }
    }
    
    func clear() -> Completable {
        return Completable.from {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LogEntity")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            
            try self.context.execute(deleteRequest)
        }
        
    }
    
    private func getAllSync() throws -> [LogModel] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LogEntity")
        request.returnsObjectsAsFaults = false
        
        let result = try context.fetch(request)
        return try result.map {
            $0 as! LogEntity
        }
        .map {
            try decoder.decode(LogModel.self, from: $0.data!.data(using: .utf8)!)
        }
    }
    
}
