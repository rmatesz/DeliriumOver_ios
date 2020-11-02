//
//  OnboardingManager.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 05..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class OnboardingManager {
    private let userDefaults: UserDefaults
    private let trigger: BehaviorSubject<Void> = BehaviorSubject<Void>(value: ())

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func loadOnboarding(page: Page) -> Observable<[Onboarding]> {
        return trigger.flatMap { _ -> Observable<[Onboarding]> in
            self.userDefaults.rx.observe([String].self, self.getKey(forPage: page))
                .map { (value) -> [Onboarding] in
                    page.onboarding().filter { !(value ?? []).contains($0.rawValue) }
                }
        }
    }

    private func completedOnboarding(forPage page: Page) -> [String] {
        return userDefaults.stringArray(forKey: getKey(forPage: page)) ?? []
    }

    func markFinished(page: Page, onboarding: Onboarding) {
        userDefaults.setValue(
            completedOnboarding(forPage: page) + [onboarding.rawValue],
            forKey: getKey(forPage: page))
        trigger.onNext(())
    }

    private func getKey(forPage page: Page) -> String {
        return "OnboardingFinishedForPage_\(page.rawValue)"
    }

    enum Page: String {
        case reports

        func onboarding() -> [Onboarding] {
            switch self {
            case .reports: return [.addConsumption,.manageConsumptions,.disclaimer,.setupSessionData]
            }
        }
    }

    enum Onboarding: String {
        case addConsumption
        case manageConsumptions
        case disclaimer
        case setupSessionData
    }
}
