//
//  SessionAutoClosingManager.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 20..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class AutoSessionCloserImpl {
    private let sessionRepository: SessionRepository
    private let alcoholCalculator: AlcoholCalculatorRxDecorator
    private let timeTrigger = BehaviorSubject<Void?>(value: nil)
    private let disposeBag = DisposeBag()

    init(sessionRepository: SessionRepository, alcoholCalculator: AlcoholCalculatorRxDecorator) {
        self.sessionRepository = sessionRepository
        self.alcoholCalculator = alcoholCalculator
    }

    func start() {
        Observable.combineLatest(sessionRepository.inProgressSession, timeTrigger.asObservable())
            .flatMap { self.createNewSessionIfExpired(session: $0.0).andThen(Single.just($0.0)) }
            .subscribe(onNext: { _ in
                NotificationCenter.default.post(name: NSNotification.Name("SESSION_EXPIRED"), object: nil)
            }, onError: {
                Logger.e(category: "DATABASE", message: "Auto session closer failed. Unable to recover from this error!", error: $0)
            })
            .disposed(by: disposeBag)
    }

    private func createNewSessionIfExpired(session: Session) -> Completable {
            return alcoholCalculator.calcTimeOfZeroBAC(session: session)
                .flatMapCompletable { (timeOfZeroBAC) -> Completable in
                    if !session.consumptions.isEmpty && dateProvider.currentDate > timeOfZeroBAC {
                        Logger.i(category: "DATABASE",
                                 message: "Alcohol is already eliminated. Closing session...")
                        var mutableSession = session
                        mutableSession.inProgress = false
                        return self.sessionRepository.update(session: mutableSession)
                            .do(onError: { Logger.w(category: "DATABASE", message: "Auto session closer failed.", error: $0) })
                            .catchError {_ in
                                Completable.never()
                            }
                    } else {
                        if !session.consumptions.isEmpty {
                            let queue = DispatchQueue.global(qos: .background)
                            let distance = timeOfZeroBAC.timeIntervalSince1970 -
                                dateProvider.currentDate.timeIntervalSince1970
                            queue.asyncAfter(deadline: .now() + distance) {
                                self.timeTrigger.onNext(nil)
                            }
                        }
                        return Completable.never()
                    }
            }
        }
}
