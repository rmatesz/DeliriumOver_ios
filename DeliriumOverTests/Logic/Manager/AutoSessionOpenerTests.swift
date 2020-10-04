//
//  AutoSessionCloserTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 26..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import XCTest
import Cuckoo
import RxSwift
@testable import DeliriumOver

class AutoSessionOpenerTests: XCTestCase {
    private lazy var sessionInProgress: Session = Session(id: "TEST", name: "Mate", weight: 77, height: 188, gender: Sex.MALE, consumptions: [], inProgress: true, deviceId: "deviceID")
    private lazy var sessionClosed: Session = Session(id: "TEST", name: "Mate", weight: 77, height: 188, gender: Sex.MALE, consumptions: [], inProgress: false, deviceId: "deviceID")
    private let sessionRepository = MockSessionRepository()
    private lazy var underTest = AutoSessionOpenerImpl(sessionRepository: sessionRepository)

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testNewSessionOpenedWhenSessionListIsEmpty() {
        stub(sessionRepository) { mock in
            when(mock.sessions).get.thenReturn(Observable.just([]))
            when(mock.insert(session: any())).thenReturn(Single.just("SESSION_ID"))
        }

        underTest.start()

        let newSession = Session(inProgress: true)
        verify(sessionRepository).insert(session: newSession)
    }

    func testClonedSessionOpenedWhenSessionListContainsNoInProgressSession() {
        stub(sessionRepository) { mock in
            when(mock.sessions).get.thenReturn(Observable.just([sessionClosed]))
            when(mock.insert(session: any())).thenReturn(Single.just("SESSION_ID"))
        }

        underTest.start()

        let newSession = Session(name: "Mate", weight: 77, height: 188, gender: Sex.MALE, inProgress: true, deviceId: "deviceID")
        verify(sessionRepository).insert(session: newSession)
    }

    func testSessionNotOpenedWhenSessionListContainsInProgressSession() {
        stub(sessionRepository) { mock in
            when(mock.sessions).get.thenReturn(Observable.just([sessionInProgress, sessionClosed]))
        }

        underTest.start()

        verify(sessionRepository, never()).insert(session: any())
    }

    func testRecoveringAfterInsertError() {
        let error = "ERROR HAPPENED"
        stub(sessionRepository) { mock in
            when(mock.sessions).get.thenReturn(Observable.from([[sessionClosed], [sessionClosed]]))
            when(mock.insert(session: any())).thenReturn(Single.error(error), Single.just("SESSION ID"))
        }

        underTest.start()

        let newSession = Session(name: "Mate", weight: 77, height: 188, gender: Sex.MALE, inProgress: true, deviceId: "deviceID")
        verify(sessionRepository, times(2)).insert(session: newSession)
    }

    func testSessionListErrorHandled() {
        let error = "ERROR HAPPENED"
        stub(sessionRepository) { mock in
            when(mock.sessions).get.thenReturn(Observable.error(error))
        }

        underTest.start()
    }
}
