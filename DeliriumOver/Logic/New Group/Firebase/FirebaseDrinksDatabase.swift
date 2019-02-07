//
//  FirebaseDrinksDatabase.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import FirebaseDatabase
import RxSwift

class FirebaseDrinksDatabase {
    private let firebaseDatabase: DatabaseReference
    
    init(firebaseDatabase: DatabaseReference) {
        self.firebaseDatabase = firebaseDatabase
    }
    
    func getDrinks() -> Single<[Drink]> {
        return Single.create(subscribe: { (observer) -> Disposable in
            self.firebaseDatabase.child("drinks").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                let data = snapshot.value as? [Drink]
                if (data != nil) {
                    observer(.success(data!))
                }
            })
            return Disposables.create()
        })
    }
}
