//
//  FirebaseCommunicator.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class FirebaseCommunicator {
    private let firebaseSessionDatabase: FirebaseSessionDatabase
    private let firebaseAuthentication: FirebaseAuthentication
    private let disposeBag = DisposeBag()
    
    init(firebaseSessionDatabase: FirebaseSessionDatabase, firebaseAuthentication: FirebaseAuthentication) {
        self.firebaseSessionDatabase = firebaseSessionDatabase
        self.firebaseAuthentication = firebaseAuthentication
    }
    
    func getSessions(shareKey: String) -> Observable<[Session]> {
        return firebaseAuthentication.authenticate()
            .asObservable()
            .flatMap({ (user) -> Observable<[Session]> in
                self.firebaseSessionDatabase.loadData(shareKey: shareKey)
            })
    }
    
    func updateSessions(sessions: [Session]) {
        firebaseAuthentication.authenticate()
            .subscribe(onSuccess: { (user) in
                let filteredSessions = sessions.filter({ (session) -> Bool in
                    !session.shareKey.isEmpty
                })
                for session in filteredSessions {
                    self.firebaseSessionDatabase.update(session: session, shareKey: session.shareKey, userId: user.uid)
                        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                        .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                        .subscribe(onCompleted: { }, onError: { (error) in
                            // TODO: log
                        })
                        .disposed(by: self.disposeBag)
                }
            }, onError: { (error) in
                // TODO: log
            }).disposed(by: disposeBag)
    }
    
    func deleteSession(shareKey: String) -> Completable {
        return firebaseAuthentication.authenticate()
            .flatMapCompletable({ (user) -> Completable in
                self.firebaseSessionDatabase.update(session: nil, shareKey: shareKey, userId: user.uid)
        })
    }
    
    func loadMinVersionForShare() -> Single<Int> {
        return firebaseSessionDatabase.getMinVersionForShare()
    }
}
