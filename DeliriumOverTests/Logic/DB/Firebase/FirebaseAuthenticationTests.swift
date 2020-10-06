//
//  FirebaseAuthenticationTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
import FirebaseAuth
import XCTest
@testable import DeliriumOver

class FirebaseAuthenticationTests: XCTestCase {
    private let user = FirebaseUser(forTest: true)
    private let firebaseAuth = MockFirebaseAuth(forTest: true)
    private lazy var underTest = FirebaseAuthenticationImpl(firebaseAuth: firebaseAuth)

    func testAuthenticateWhenAlreadyLoggedIn() throws {
        stub(firebaseAuth) { mock in
            mock.currentUser.get.thenReturn(user)
        }

        let result = try underTest.authenticate().toBlocking().single()

        XCTAssertEqual(user, result)
    }

    func testAuthenticateWhenSuccess() {
        let completionHandler = ArgumentCaptor<((AuthDataResult?, Error?) -> Void)?>()
        stub(firebaseAuth) { mock in
            mock.currentUser.get.thenReturn(nil)
            mock.signInAnonymously(completion: completionHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.authenticate().subscribe(onSuccess: { (result) in
            XCTAssertEqual(self.user, result)
            emission.fulfill()
        }, onError: { e in

        })

        completionHandler.value!!(FirebaseAuthDataResult(user: user), nil)

        waitForExpectations(timeout: 2)
    }

    func testAuthenticateWhenNoResultAndNoError() {
        let completionHandler = ArgumentCaptor<((AuthDataResult?, Error?) -> Void)?>()
        stub(firebaseAuth) { mock in
            mock.currentUser.get.thenReturn(nil)
            mock.signInAnonymously(completion: completionHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.authenticate().subscribe(onSuccess: { (result) in
        }, onError: { error in
            XCTAssertEqual(FirebaseError.authenticationError, error as! FirebaseError)
            emission.fulfill()
        })

        completionHandler.value!!(nil, nil)

        waitForExpectations(timeout: 2)
    }

    func testAuthenticateWhenError() {
        let error = "Error"
        let completionHandler = ArgumentCaptor<((AuthDataResult?, Error?) -> Void)?>()
        stub(firebaseAuth) { mock in
            mock.currentUser.get.thenReturn(nil)
            mock.signInAnonymously(completion: completionHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.authenticate().subscribe(onSuccess: { (result) in
        }, onError: { e in
            XCTAssertEqual(error, e as! String)
            emission.fulfill()
        })

        completionHandler.value!!(nil, error)

        waitForExpectations(timeout: 2)
    }
}
