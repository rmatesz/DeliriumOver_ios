//
//  FirebaseSessionDatabase.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 07..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseDatabase

protocol FirebaseSessionDatabase {
    func loadData(shareKey: String) -> Observable<[Session]>
    func update(session: Session?, shareKey: String, userId: String) -> Completable
    func getMinVersionForShare() -> Single<Int>
}

class FirebaseSessionDatabaseImpl: FirebaseSessionDatabase {
    private let kSessionsNode = "share_sessions"
    private let kShareVersion = "share_version"
    private let firebaseDatabase: DatabaseReference

    init(firebaseDatabase: DatabaseReference) {
        self.firebaseDatabase = firebaseDatabase
    }

    func loadData(shareKey: String) -> Observable<[Session]> {
        if (shareKey.isEmpty) {
            return Observable.just([])
        } else {
            return Observable.create({ (observer) -> Disposable in
                let databaseRef = self.firebaseDatabase
                    .child(self.kSessionsNode)
                    .child(shareKey)
                databaseRef.keepSynced(true)
                let databaseObserver = databaseRef.observe(DataEventType.value, with: { (snapshot) in
                    guard let data = snapshot.value as? [String:Session] else {
                        observer.onError(DatabaseError(message: "Data returned from Firebase database is in invalid format. Expected [String:Session]. Actual \(type(of: snapshot.value).self)"))
                        return
                    }
                    observer.onNext(data.map({ (key, value) -> Session in
                        value
                    }))
                }, withCancel: { (error) in
                    observer.onError(error)
                })
                return Disposables.create {
                    databaseRef.removeObserver(withHandle: databaseObserver)
                }
            })
        }
    }
    
    func update(session: Session?, shareKey: String, userId: String) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            self.firebaseDatabase.child(self.kSessionsNode).child(shareKey).child(userId)
                .setValue(session, withCompletionBlock: { (databaseError, databaseRef) in
                    if (databaseError == nil) {
                        observer(.completed)
                    } else {
                        observer(.error(databaseError!))
                    }
                })
            return Disposables.create()
        })
    }

    func getMinVersionForShare() -> Single<Int> {
        return Single.create(subscribe: { (observer) -> Disposable in
            self.firebaseDatabase.child(self.kShareVersion)
                .observeSingleEvent(of: DataEventType.value, with: { (dataSnapshot) in
                    observer(.success(dataSnapshot.value as? Int ?? 0))
                }, withCancel: { (error) in
                    observer(.error(error))
                })
            return Disposables.create()
        })
    }
}
