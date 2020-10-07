//
//  SessionFormViewModelImpl.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 28..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import XCTest
import Cuckoo
import RxSwift
import RxTest
@testable import DeliriumOver

class SessionFormViewModelTests: XCTestCase {
    private let sessionName = "TEST NAME"
    private let weight: Double = 88
    private let weightStr = "88"
    private let gender = Sex.MALE

    private let newSessionName = "NEW NAME"
    private let newWeight: Double = 100.12
    private let newWeightStr = "100.1200"
    private let newGender = Sex.FEMALE

    private lazy var session = Session(name: sessionName, weight: weight, gender: gender)
    private lazy var sessionToUpdate = Session(name: newSessionName, weight: newWeight, gender: newGender)
    private lazy var sessionToUpdateWhenInvalidWeight = Session(name: newSessionName, weight: 0.0, gender: newGender)

    private let sessionRepository = MockSessionRepository()

    private lazy var underTest = SessionFormViewModelImpl(sessionRepository: sessionRepository)

    func testDataPopulatedFromInProgressSession() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
        }

        XCTAssertEqual(sessionName, underTest.name.value)
        XCTAssertEqual(weightStr, underTest.weight.value)
        XCTAssertEqual(gender, underTest.gender.value)
    }

    func testSessionUpdate() throws {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
            when(mock.update(session: any())).thenReturn(Completable.empty())
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept(newWeightStr)

        _ = try underTest.saveSession().toBlocking().first()

        verify(sessionRepository).update(session: sessionToUpdate)
    }

    func testSessionUpdateEmitsRepoUpdateError() {
        let error = "TEST ERROR"
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
            when(mock.update(session: any())).thenReturn(Completable.error(error))
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept(newWeightStr)

        do {
            _ = try underTest.saveSession().toBlocking().first()
        } catch let e{
            XCTAssertEqual(error, e as! String)
        }
    }

    func testSessionUpdateWithInvalidWeightValueUSesZeroAsFallbackValue() throws {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.just(session))
            when(mock.update(session: any())).thenReturn(Completable.empty())
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept("newWeightStr")

        _ = try underTest.saveSession().toBlocking().first()

        // THEN
        verify(sessionRepository).update(session: sessionToUpdateWhenInvalidWeight)
    }

    func testSessionUpdateEmitsInProgressSessionError() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.error("TEST ERROR"))
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept(newWeightStr)

        do {
            _ = try underTest.saveSession().toBlocking().first()
        } catch {
            assert(error is RepositoryError)
        }
    }

    func testSessionUpdateThrowsRepositoryErrorWhenInProgressSessionDoesNotEmmit() {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.never())
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept(newWeightStr)

        do {
            _ = try underTest.saveSession().toBlocking().first()
        } catch {
            assert(error is RepositoryError)
        }
    }

    func testSessionUpdateThrowsRepositoryErrorWhenNoInProgressSession() throws {
        stub(sessionRepository) { mock in
            when(mock.inProgressSession.get).thenReturn(Observable.empty())
        }

        // WHEN
        underTest.name.accept(newSessionName)
        underTest.gender.accept(newGender)
        underTest.weight.accept(newWeightStr)

        let exp = expectation(description: "Waiting for timeout")
        let scheduler = TestScheduler(initialClock: 0)
        _ = underTest.saveSession()
            .observeOn(scheduler)
            .subscribeOn(scheduler)
            .subscribe(onError: { (error) in
                assert(error is RepositoryError)
                exp.fulfill()
            })
        scheduler.start()

        waitForExpectations(timeout: 5)
    }
}
