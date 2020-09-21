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

class FirebaseAuthentication {
    let firebaseAuth: Auth
    
    init(firebaseAuth: Auth) {
        self.firebaseAuth = firebaseAuth
    }
    
    func authenticate() -> Single<User> {
        if (firebaseAuth.currentUser != nil) {
            return Single.just(firebaseAuth.currentUser!)
        }
        else {
            return Single<User>.create { (observer: @escaping (SingleEvent<User>) -> ()) -> Disposable in
                self.firebaseAuth.signInAnonymously(completion: { (result, error) in
                    if (result != nil) {
                        observer(.success(result!.user))
                    } else if (error != nil) {
                        observer(.error(error!))
                    } else {
                        observer(.error(FirebaseError.authenticationError))
                    }
                })
                return Disposables.create()
            }
        }
    }
}
