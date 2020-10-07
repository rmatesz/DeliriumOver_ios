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
        guard !shareKey.isEmpty else {
            return Observable.just([])
        }
        let databaseRef = self.firebaseDatabase
            .child(self.kSessionsNode)
            .child(shareKey)
        databaseRef.keepSynced(true)
        return databaseRef.observableValue()
            .map { (value: [String: Session]) -> [Session] in
                value.map { $0.value }
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
        return self.firebaseDatabase.child(self.kShareVersion).singleValue()
    }
}
