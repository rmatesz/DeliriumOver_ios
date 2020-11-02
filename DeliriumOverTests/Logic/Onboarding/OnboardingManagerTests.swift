//
//  OnboardingManagerTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 05..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import XCTest
@testable import DeliriumOver

class OnboardingManagerTests: XCTestCase {
    private let userDefaults = UserDefaults(suiteName: "unitTest")!
    private lazy var underTest = OnboardingManager(userDefaults: userDefaults)
    private var disposeBag = DisposeBag()

    override func setUp() {
        userDefaults.removeObject(forKey: "OnboardingFinishedForPage_reports")
    }

    func testLoadOnboardingForReports() {
        let waitingForDispose = expectation(description: "waiting for dipose")
        var counter = 0
        underTest.loadOnboarding(page: .reports)
            .subscribeOn(MainScheduler())
            .observeOn(MainScheduler())
            .subscribe(onNext: { (actual) in
            let expected: [OnboardingManager.Onboarding]
            switch counter {
                case 0: expected = [OnboardingManager.Onboarding.addConsumption, .manageConsumptions, .disclaimer, .setupSessionData]
                case 1: expected = [OnboardingManager.Onboarding.addConsumption, .manageConsumptions, .setupSessionData]
                default: expected = []
            }
            XCTAssertEqual(expected, actual, "Assertion #\(counter) failed!")
            counter = counter + 1
            if counter == 1 {
                self.underTest.markFinished(page: .reports, onboarding: .disclaimer)
            } else if counter > 1 {
                waitingForDispose.fulfill()
            }
        }, onCompleted: { XCTFail() })

        .disposed(by: disposeBag)

        waitForExpectations(timeout: 2)
    }
}
