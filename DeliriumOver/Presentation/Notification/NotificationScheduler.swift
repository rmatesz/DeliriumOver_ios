//
//  NotificationScheduler.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 16..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import UserNotifications

class NotificationScheduler {
    private let sessionRepository: SessionRepository
    private let alcoholCalculator: AlcoholCalculatorRxDecorator
    private let notificationCenter = UNUserNotificationCenter.current()
    private let disposeBag = DisposeBag()

    init(sessionRepository: SessionRepository, alcoholCalculator: AlcoholCalculatorRxDecorator) {
        self.sessionRepository = sessionRepository
        self.alcoholCalculator = alcoholCalculator
    }

    func start() {
        sessionRepository.inProgressSession
            .flatMap({ (session) -> Single<Date> in
                self.alcoholCalculator.calcTimeOfZeroBAC(session: session)
            })
            .filter {
                $0 > Date()
            }
        .subscribe(onNext: { self.scheduleNotification($0) })
        .disposed(by: disposeBag)
    }

    private func scheduleNotification(_ date: Date) {
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                self.requestPermission()
            } else {
                let content = UNMutableNotificationContent()
                content.title = "Delirium Over!"
                content.body = "The consumed alcohol has been probably eliminated from your body! All measurements are an average for a healthy (healthy liver) person. It highly depends on the actual state of mind, emptyness of stomach and drinking habits. If you'd like to drive, wait more than the displayed degradation time, before you can safely sit in the car."
                content.sound = UNNotificationSound.default()
                let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
                let identifier = "UYLLocalNotification"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

                self.notificationCenter.add(request, withCompletionHandler: { (error) in
                    if let error = error {
                        // Something went wrong
                    }
                })
            }
        }
    }

    private func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .sound]

        notificationCenter.requestAuthorization(options: options) { (granted, error) in
            if !granted {
                print("Something went wrong")
            }
        }
    }
}
