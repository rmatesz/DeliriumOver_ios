//
//  ApplicationSwinjectStoryboard.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject
import FirebaseDatabase
import FirebaseAuth

class FirebaseSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(Auth.self) { (resolver) -> Auth in
            Auth.auth()
        }
        
        defaultContainer.register(DatabaseReference.self) { (resolver) -> DatabaseReference in
            Database.database().reference()
        }
        
        defaultContainer.register(FirebaseAuthentication.self) { (resolver) -> FirebaseAuthentication in
            FirebaseAuthentication(firebaseAuth: resolver.resolve(Auth.self)!)
        }
        
        defaultContainer.register(FirebaseSessionDatabase.self) { (resolver) -> FirebaseSessionDatabase in
            FirebaseSessionDatabase(firebaseDatabase: resolver.resolve(DatabaseReference.self)!)
        }
        
        defaultContainer.register(FirebaseCommunicator.self) { (resolver) -> FirebaseCommunicator in
            FirebaseCommunicator(firebaseSessionDatabase: resolver.resolve(FirebaseSessionDatabase.self)!, firebaseAuthentication: resolver.resolve(FirebaseAuthentication.self)!)
        }
        
        defaultContainer.register(FirebaseDrinksDatabase.self) { (resolver) -> FirebaseDrinksDatabase in
            FirebaseDrinksDatabase(firebaseDatabase: resolver.resolve(DatabaseReference.self)!)
        }
    }
}
