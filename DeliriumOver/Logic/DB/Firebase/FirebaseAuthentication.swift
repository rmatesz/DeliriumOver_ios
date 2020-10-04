//
//  FirebaseAuthentication.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import FirebaseAuth

protocol FirebaseAuthentication {
    func authenticate() -> Single<User>
}

class FirebaseAuthenticationImpl: FirebaseAuthentication {
    let firebaseAuth: Auth
    
    init(firebaseAuth: Auth) {
        self.firebaseAuth = firebaseAuth
    }
    
    func authenticate() -> Single<User> {
        if (firebaseAuth.currentUser != nil) {
            return Single.just(firebaseAuth.currentUser!)
        } else {
            return Single<User>.create { (observer: @escaping (SingleEvent<User>) -> ()) -> Disposable in
                self.firebaseAuth.signInAnonymously(completion: { (result, error) in
                    guard let result = result else {
                        guard let error = error else {
                            observer(.error(FirebaseError.authenticationError))
                            return
                        }
                        observer(.error(error))
                        return
                    }
                    observer(.success(result.user))
                })
                return Disposables.create()
            }
        }
    }
}
