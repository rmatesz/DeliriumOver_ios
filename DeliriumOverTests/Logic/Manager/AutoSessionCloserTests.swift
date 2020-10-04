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

class AutoSessionCloserTests: XCTestCase {
    private let consumption: Consumption = Consumption("TEST_CONSUMPTION", drink: "BEER", quantity: 1, unit: .liter, alcohol: 0.05, date: Date())
    private lazy var session: Session = Session(id: "TEST", consumptions: [consumption], inProgress: true)
    private let emptySession: Session = Session(id: "TEST", inProgress: true)
    private lazy var sessionClosed: Session = Session(id: "TEST", consumptions: [consumption], inProgress: false)
    private let sessionRepository = MockSessionRepository()
    private let alcoholCalculatorMock = MockAlcoholCalculator()
    private let past = Date(timeIntervalSince1970: 1000)
    private let now = Date(timeIntervalSince1970: 2000)
    private let future = Date(timeIntervalSince1970: 3000)
    private lazy var alcoholCalculator = AlcoholCalculatorRxDecorator(alcoholCalculator: alcoholCalculatorMock)
    private lazy var underTest = AutoSessionCloserImpl(sessionRepository: sessionRepository, alcoholCalculator: alcoholCalculator)

    override func setUp() {
        super.setUp()
        dateProvider = TestDateProvider(date: now)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDemo() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession).get.thenReturn(Observable.never())
        }

        underTest.start()

        verify(sessionRepository, never()).update(session: any())
    }

    func testSessionNotClosedWhenEstimatedAlcoholEliminationIsInFuture() {
        stub(sessionRepository) {  mock in
            when(mock.inProgressSession).get.thenReturn(Observable.just(session))
        }

        stub(alcoholCalculatorMock) { mock in
            when(mock.calcTimeOfZeroBAC(session)).thenReturn(future)
        }

        underTest.start()

        verify(sessionRepository, never()).update(session: any())
    }

    func testSessionNotClosedWhenSessionIsEmpty() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession).get.thenReturn(Observable.just(emptySession))
        }

        stub(alcoholCalculatorMock) { mock in
            when(mock.calcTimeOfZeroBAC(emptySession)).thenReturn(past)
        }

        underTest.start()

        verify(sessionRepository, never()).update(session: any())
    }

    func testSessionClosedWhenEstimatedAlcoholEliminationIsInPast() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession).get.thenReturn(Observable.just(session))
            when(mock.update(session: sessionClosed)).thenReturn(Completable.empty())
        }

        stub(alcoholCalculatorMock) { mock in
            when(mock.calcTimeOfZeroBAC(session)).thenReturn(past)
        }

        underTest.start()

        verify(sessionRepository).update(session: sessionClosed)
    }

    func testRecoveringAfterUpdateError() {
        let error = "ERROR HAPPENED"
        stub(sessionRepository) { mock in
            when(mock.inProgressSession).get.thenReturn(Observable.from([session, session]))
            when(mock.update(session: sessionClosed)).thenReturn(Completable.error(error), Completable.empty())
        }

        stub(alcoholCalculatorMock) { mock in
            when(mock.calcTimeOfZeroBAC(session)).thenReturn(past)
        }

        underTest.start()

        verify(sessionRepository, times(2)).update(session: sessionClosed)
    }

    func testInProgressSessionErrorHandled() {
        let error = "ERROR HAPPENED"
        stub(sessionRepository) { mock in
            when(mock.inProgressSession).get.thenReturn(Observable.error(error))
        }

        underTest.start()
    }
}
