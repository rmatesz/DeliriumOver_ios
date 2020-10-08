//
//  FirebaseSessionDatabaseTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Cuckoo
@testable import FirebaseDatabase
import Foundation
import XCTest
@testable import DeliriumOver

class FirebaseSessionDatabaseTests: XCTestCase {
    private let shareKey = "SHARE KEY"
    private let userId = "USER ID"
    private let sessionId = "s1"
    private lazy var session = Session(id: sessionId)
    private let sessionId2 = "s2"
    private lazy var session2 = Session(id: sessionId2)
    private let databaseReference = MockFirebaseDatabaseReference()
    private let sessionsNode = MockFirebaseDatabaseReference()
    private let shareVersionNode = MockFirebaseDatabaseReference()
    private let shareKeyNode = MockFirebaseDatabaseReference()
    private let userNode = MockFirebaseDatabaseReference()
    private lazy var underTest = FirebaseSessionDatabaseImpl(firebaseDatabase: databaseReference)

    override func setUp() {
        stub(databaseReference) { mock in
            mock.child("share_sessions").thenReturn(sessionsNode)
            mock.child("share_version").thenReturn(shareVersionNode)
        }

        stub(sessionsNode) { mock in
            mock.child(shareKey).thenReturn(shareKeyNode)
        }

        stub(shareKeyNode) { mock in
            mock.keepSynced(any()).thenDoNothing()
            mock.child(userId).thenReturn(userNode)
        }
    }

    func testLoadData() throws {
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        let observer: UInt = 123
        stub(shareKeyNode) { mock in
            mock.observe(DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenReturn(observer)
        }

        let sessionEmitted = expectation(description: "Session has been emitted")

        _ = underTest.loadData(shareKey: shareKey).subscribe(onNext: { (result) in
            XCTAssertEqual([self.session], result)
            sessionEmitted.fulfill()
        })
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId:session]))

        verify(shareKeyNode).keepSynced(true)
        waitForExpectations(timeout: 2)
    }

    func testLoadDataWhenShareKeyIsEmpty() throws {
        let result = try underTest.loadData(shareKey: "").toBlocking().toArray()
        XCTAssertEqual([[]], result)
    }

    func testLoadDataEmitsMultipleResult() throws {
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        let observer: UInt = 123
        stub(shareKeyNode) { mock in
            mock.observe(DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenReturn(observer)
        }

        let sessionEmitted = expectation(description: "Session has been emitted")

        var counter = 0
        _ = underTest.loadData(shareKey: shareKey).subscribe(onNext: { (result) in
            if counter == 0 {
                XCTAssertEqual([self.session], result)
                counter = counter + 1
            } else {
                XCTAssertEqual(
                    [self.session, self.session2]
                        .sorted(by: { (s1, s2) in s1.id > s2.id }),
                    result
                        .sorted(by: { (s1, s2) in s1.id > s2.id })
                )
                sessionEmitted.fulfill()
            }
        })
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId:session]))
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId:session,sessionId2:session2]))

        verify(shareKeyNode).keepSynced(true)
        waitForExpectations(timeout: 2)
    }

    func testLoadDataDoesNotEmitAfterDisposed() throws {
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        let observer: UInt = 123
        stub(shareKeyNode) { mock in
            mock.observe(DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenReturn(observer)
        }

        let sessionEmitted = expectation(description: "Session has been emitted")

        var counter = 0
        let disposable = underTest.loadData(shareKey: shareKey).subscribe(onNext: { (result) in
            if counter == 0 {
                XCTAssertEqual([self.session], result)
                counter = counter + 1
            } else {
                XCTFail("Already disposed!")
            }
        }, onDisposed: { sessionEmitted.fulfill() })
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId:session]))
        disposable.dispose()
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId:session,sessionId2:session2]))

        verify(shareKeyNode).keepSynced(true)
        waitForExpectations(timeout: 2)
    }

    func testLoadDataWhenError() throws {
        let error = "ERROR"
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        let observer: UInt = 123
        stub(shareKeyNode) { mock in
            mock.observe(DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenReturn(observer)
        }

        let sessionEmitted = expectation(description: "Session has been emitted")

        _ = underTest.loadData(shareKey: shareKey).subscribe(onError: { (e) in
            XCTAssertEqual(error, e as! String)
            sessionEmitted.fulfill()
        })

        cancelHandler.value!!(error)

        verify(shareKeyNode).keepSynced(true)
        waitForExpectations(timeout: 2)
    }

    func testLoadDataWhenInvalidDataReturnedFromDB() throws {
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        let observer: UInt = 123
        stub(shareKeyNode) { mock in
            mock.observe(DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenReturn(observer)
        }

        let sessionEmitted = expectation(description: "Session has been emitted")

        _ = underTest.loadData(shareKey: shareKey).subscribe(onError: { (error) in
            assert(error is DatabaseError)
            sessionEmitted.fulfill()
        })
        successfulHandler.value!(MockDataSnapshot(mockData: [sessionId,session]))

        verify(shareKeyNode).keepSynced(true)
        waitForExpectations(timeout: 2)
    }

    // update
    func testUpdate() {
        // GIVEN
        let completionHandler = ArgumentCaptor<(Error?, DatabaseReference) -> Void>()
        let sessionCaptor = ArgumentCaptor<Any?>()
        let emission = expectation(description: "Waiting for emission")
        stub(userNode) { mock in
            mock.setValue(sessionCaptor.capture(), withCompletionBlock: completionHandler.capture()).thenDoNothing()
        }

        // WHEN
        _ = underTest.update(session: session, shareKey: shareKey, userId: userId).subscribe(onCompleted: {
            emission.fulfill()
        })

        completionHandler.value!(nil, userNode)

        verify(userNode).setValue(sessionCaptor.capture(), withCompletionBlock: completionHandler.capture())
        XCTAssertEqual(session, sessionCaptor.value!! as! Session)

        waitForExpectations(timeout: 2)
    }

    func testUpdateWhenError() {
        // GIVEN
        let error = "ERROR"
        let completionHandler = ArgumentCaptor<(Error?, DatabaseReference) -> Void>()
        let sessionCaptor = ArgumentCaptor<Any?>()
        let emission = expectation(description: "Waiting for emission")
        stub(userNode) { mock in
            mock.setValue(sessionCaptor.capture(), withCompletionBlock: completionHandler.capture()).thenDoNothing()
        }

        // WHEN
        _ = underTest.update(session: session, shareKey: shareKey, userId: userId).subscribe(onError: { e in
            XCTAssertEqual(error, e as! String)
            emission.fulfill()
        })

        completionHandler.value!(error, userNode)

        verify(userNode).setValue(sessionCaptor.capture(), withCompletionBlock: completionHandler.capture())
        XCTAssertEqual(session, sessionCaptor.value!! as! Session)

        waitForExpectations(timeout: 2)
    }

    // getMinVersionForShare
    func testGetMinVersionForShare() {
        let version = 32
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        stub(shareVersionNode) { mock in
            mock.observeSingleEvent(of: DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.getMinVersionForShare().subscribe(onSuccess: { (result) in
            XCTAssertEqual(version, result)
            emission.fulfill()
        })

        successfulHandler.value!(MockDataSnapshot(mockData: version))

        waitForExpectations(timeout: 2)
    }

    func testGetMinVersionForShareWhenError() {
        let error = "ERROR"
        let successfulHandler = ArgumentCaptor<(DataSnapshot) -> Void>()
        let cancelHandler = ArgumentCaptor<((Error) -> Void)?>()
        stub(shareVersionNode) { mock in
            mock.observeSingleEvent(of: DataEventType.value, with: successfulHandler.capture(), withCancel: cancelHandler.capture()).thenDoNothing()
        }

        let emission = expectation(description: "Waiting for emission")

        _ = underTest.getMinVersionForShare().subscribe(onError: { (e) in
            XCTAssertEqual(error, e as! String)
            emission.fulfill()
        })

        cancelHandler.value!!(error)

        waitForExpectations(timeout: 2)
    }
}

extension DataEventType: Matchable { }
extension Session: OptionalMatchable { }
