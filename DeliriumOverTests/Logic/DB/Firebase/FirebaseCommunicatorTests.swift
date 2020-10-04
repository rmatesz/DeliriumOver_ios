//
//  FirebaseCommunicatorTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import Cuckoo
import RxSwift
import XCTest
@testable import DeliriumOver

class FirebaseCommunicatorTests: XCTestCase {
    private let firebaseSessionDatabase = MockFirebaseSessionDatabase()
    private let firebaseAuthentication = MockFirebaseAuthentication()
    private let session1 = Session(id: "session1", title: "Session 1", description: "", name: "user", weight: 78, height: 178, gender: .FEMALE, consumptions: [], inProgress: false, deviceId: "deviceId", shared: true, shareKey: "SHARE KEY")
    private let session2 = Session(id: "session2", title: "Session 2", description: "", name: "user", weight: 78, height: 178, gender: .FEMALE, consumptions: [], inProgress: true, deviceId: "deviceId", shared: false, shareKey: "")
    private let session3 = Session(id: "session3", title: "Session 3", description: "", name: "user", weight: 78, height: 178, gender: .FEMALE, consumptions: [], inProgress: true, deviceId: "deviceId", shared: false, shareKey: "afskj")
    private lazy var underTest = FirebaseCommunicator(firebaseSessionDatabase: firebaseSessionDatabase, firebaseAuthentication: firebaseAuthentication)

    func testGetSessions() throws {
        let shareKey = "SHAREKEY"
        let userId = "UserId"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.loadData(shareKey: shareKey).thenReturn(Observable.from([[session1],[session1, session3]]))
        }

        let result = try underTest.getSessions(shareKey: shareKey).toBlocking().toArray()

        XCTAssertEqual([[session1], [session1, session3]], result)
    }

    func testGetSessionsWhenAuthenticationError() throws {
        let shareKey = "SHAREKEY"
        let userId = "UserId"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.loadData(shareKey: shareKey).thenReturn(Observable.from([[session1],[session1, session3]]))
        }

        let result = try underTest.getSessions(shareKey: shareKey).toBlocking().toArray()

        XCTAssertEqual([[session1], [session1, session3]], result)
    }

    func testGetSessionsWhenLoadError() throws {
        let shareKey = "SHAREKEY"
        let userId = "UserId"
        let error = "ERROR"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.loadData(shareKey: shareKey).thenReturn(Observable.error(error).startWith([session1, session3]))
        }

        let getSessions = underTest.getSessions(shareKey: shareKey).toBlocking()
        let result = try getSessions.first()
        XCTAssertEqual([session1, session3], result)

        do {
            _ = try getSessions.toArray()
            assertionFailure("error should be thrown")
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testUpdateSessionsUpdatesMultipleSessions() {
        let userId = "UserId"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.update(session: any(), shareKey: any(), userId: userId).thenReturn(Completable.empty())
        }

        underTest.updateSessions(sessions: [session1, session3])

        verify(firebaseSessionDatabase).update(session: session1, shareKey: session1.shareKey, userId: userId)
        verify(firebaseSessionDatabase).update(session: session3, shareKey: session3.shareKey, userId: userId)
    }

    func testUpdateSessionsUpdatesSessionsWithNotEmptyShareKeys() {
        let userId = "UserId"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.update(session: any(), shareKey: any(), userId: userId).thenReturn(Completable.empty())
        }

        underTest.updateSessions(sessions: [session1, session2])

        verify(firebaseSessionDatabase).update(session: session1, shareKey: session1.shareKey, userId: userId)
        verify(firebaseSessionDatabase, never()).update(session: session2, shareKey: session2.shareKey, userId: userId)
    }

    func testUpdateSessionsWhenUpdateError() {
        let error = "ERROR"
        let userId = "UserId"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }
        stub(firebaseSessionDatabase) { mock in
            mock.update(session: any(), shareKey: any(), userId: userId).thenReturn(Completable.error(error))
        }

        underTest.updateSessions(sessions: [session1, session3])

        verify(firebaseSessionDatabase).update(session: session1, shareKey: session1.shareKey, userId: userId)
        verify(firebaseSessionDatabase).update(session: session3, shareKey: session3.shareKey, userId: userId)
    }

    func testUpdateSessionsWhenAuthenticationError() {
        let error = "ERROR"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.error(error))
        }

        underTest.updateSessions(sessions: [session1, session2])

        verify(firebaseSessionDatabase, never()).update(session: any(), shareKey: any(), userId: any())
    }

    func testDeleteSession() throws {
        let userId = "UserId"
        let shareKey = "ShareKey"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }

        stub(firebaseSessionDatabase) { mock in
            mock.update(session: isNil(), shareKey: shareKey, userId: userId).thenReturn(Completable.empty())
        }

        _ = try underTest.deleteSession(shareKey: shareKey).toBlocking().toArray()

        verify(firebaseSessionDatabase).update(session: isNil(), shareKey: shareKey, userId: userId)
    }

    func testDeleteSessionWhenAuthenticationError() throws {
        let shareKey = "ShareKey"
        let error = "ERROR"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.error(error))
        }

        do {
            _ = try underTest.deleteSession(shareKey: shareKey).toBlocking().toArray()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }

        verify(firebaseSessionDatabase, never()).update(session: isNil(), shareKey: shareKey, userId: any())
    }

    func testDeleteSessionWhenUpdateError() throws {
        let userId = "UserId"
        let shareKey = "ShareKey"
        let error = "ERROR"
        stub(firebaseAuthentication) { mock in
            mock.authenticate().thenReturn(Single.just(FirebaseUser(forTest: true, uid: userId)))
        }

        stub(firebaseSessionDatabase) { mock in
            mock.update(session: isNil(), shareKey: shareKey, userId: userId).thenReturn(Completable.error(error))
        }

        do {
            _ = try underTest.deleteSession(shareKey: shareKey).toBlocking().toArray()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testLoadMinVersionForShare() throws {
        let version = 10
        stub(firebaseSessionDatabase) { mock in
            mock.getMinVersionForShare().thenReturn(Single.just(10))
        }
        let result = try underTest.loadMinVersionForShare().toBlocking().single()

        XCTAssertEqual(version, result)
    }

    func testLoadMinVersionForShareWhenError() throws {
        let error = "ERROR"
        stub(firebaseSessionDatabase) { mock in
            mock.getMinVersionForShare().thenReturn(Single.error(error))
        }
        do {
            _ = try underTest.loadMinVersionForShare().toBlocking().single()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }
}
