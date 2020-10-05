//
//  OnboardingManagerTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 05..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import XCTest
@testable import DeliriumOver

class OnboardingManagerTests: XCTestCase {
    private let userDefaults = UserDefaults(suiteName: "unit_test")!
    private lazy var underTest = OnboardingManager(userDefaults: userDefaults)

    override func setUp() {
        userDefaults.removeObject(forKey: "OnboardingFinishedForPage_reports")
    }

    func testLoadOnboardingForReports() {
        let waitingForDispose = expectation(description: "waiting for dipose")
        var counter = 0
        let disposable = underTest.loadOnboarding(page: .reports).subscribe(onNext: { (actual) in
            let expected: [OnboardingManager.Onboarding]
            switch counter {
                case 0: expected = [OnboardingManager.Onboarding.addConsumption, .manageConsumptions, .disclaimer, .setupSessionData]
                case 1: expected = [OnboardingManager.Onboarding.addConsumption, .manageConsumptions, .setupSessionData]
                default: expected = []
            }
            XCTAssertEqual(expected, actual, "Assertion #\(counter) failed!")
            counter = counter + 1
        }, onError: { error in

        }, onCompleted: {

        }, onDisposed: {
            waitingForDispose.fulfill()
        })

        underTest.markFinished(page: .reports, onboarding: .disclaimer)

        disposable.dispose()

        waitForExpectations(timeout: 2) { (error) in
            guard let error = error else { return }
            assertionFailure("expectation has not been fullfilled")
        }
    }
//
//    func markFinished(page: Page, onboarding: Onboarding) {
//        userDefaults.setValue(completedOnboarding(forPage: page) + [onboarding.rawValue], forKey: page.rawValue)
//    }
}
