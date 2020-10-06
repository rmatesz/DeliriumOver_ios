//
//  Firebase.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class FirebaseDatabaseReference: DatabaseReference {
    override func child(_ pathString: String) -> DatabaseReference {
        return super.child(pathString)
    }

    override func keepSynced(_ synced: Bool) {
        super.keepSynced(synced)
    }

    override func observe(_ eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) -> UInt {
        return super.observe(eventType, with: block, withCancel: cancelBlock)
    }

    override func observeSingleEvent(of eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) {
        super.observeSingleEvent(of: eventType, with: block, withCancel: cancelBlock)
    }

    override func setValue(_ value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void) {
        super.setValue(value, withCompletionBlock: block)
    }
}

class MockDataSnapshot: DataSnapshot {
    private let mockData: Any?
    init(mockData: Any?) {
        self.mockData = mockData
    }
    override var value: Any? {
        get { return mockData }
    }
}

class FirebaseAuth: Auth {
    init(forTest: Bool) { }

    override var currentUser: User? {
        get { return super.currentUser }
    }

    override func signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)? = nil) {
        super.signInAnonymously(completion: completion)
    }
}

class FirebaseUser: User {
    private let mockUid: String

    init(forTest: Bool) {
        self.mockUid = ""
    }

    init(forTest: Bool, uid: String) {
        self.mockUid = uid
    }

    override var uid: String {
        get { return mockUid }
    }
}

class FirebaseAuthDataResult: AuthDataResult {
    private let userValue: User
    init(user: User) {
        userValue = user
    }

    override var user: User {
        get { return userValue }
    }
}
