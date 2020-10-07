//
//  FirebaseDatabaseExtensions.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 07..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseDatabase

extension DatabaseReference {
    func observableValue<T>() -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            let databaseObserver = self.observe(DataEventType.value, with: { (snapshot) in
                guard let data = snapshot.value as? T else {
                    observer.onError(DatabaseError(message: "Data returned from Firebase database is in invalid format. Expected \(T.self). Actual \(type(of: snapshot.value).self)"))
                    return
                }
                observer.onNext(data)
            }, withCancel: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
                self.removeObserver(withHandle: databaseObserver)
            }
        }
    }

    func singleValue<T>() -> Single<T> {
        return Single.create(subscribe: { (observer) -> Disposable in
            self.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                guard let data = snapshot.value as? T else {
                    observer(.error(DatabaseError(message: "Data returned from Firebase database is in invalid format. Expected \(T.self). Actual \(type(of: snapshot.value).self)")))
                    return
                }
                observer(.success(data))
            }, withCancel: { (error) in
                observer(.error(error))
            })
            return Disposables.create()
        })
    }
}
