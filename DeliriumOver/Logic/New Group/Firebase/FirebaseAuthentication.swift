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
    
    func authenticate() -> Maybe<User> {
        if (firebaseAuth.currentUser != nil) {
            return Maybe.just(firebaseAuth.currentUser!)
        }
        else {
            return Maybe<User>.create { (observer: @escaping (MaybeEvent<User>) -> ()) -> Disposable in
                self.firebaseAuth.signInAnonymously(completion: { (result, error) in
                    if (result != nil) {
                        observer(.success(result!.user))
                    } else if (error != nil) {
                        observer(.error(error!))
                    } else {
                        observer(.completed)
                    }
                })
                return Disposables.create()
            }
        }
    }
}
