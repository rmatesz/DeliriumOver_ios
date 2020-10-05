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
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

    func loadOnboarding(page: Page) -> Observable<[Onboarding]> {
        userDefaults.rx.observe([String].self, "OnboardingFinishedForPage_\(page.rawValue)")
            .map { (value) -> [Onboarding] in
                page.onboarding().filter { !(value ?? []).contains($0.rawValue) }
            }
    }

    private func completedOnboarding(forPage page: Page) -> [String] {
        return userDefaults.stringArray(forKey: page.rawValue) ?? []
    }

    func markFinished(page: Page, onboarding: Onboarding) {
        userDefaults.setValue(
            completedOnboarding(forPage: page) + [onboarding.rawValue],
            forKey: page.rawValue
        )
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
