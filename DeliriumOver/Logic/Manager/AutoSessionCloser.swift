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
    private let disposeBag = DisposeBag()

    init(sessionRepository: SessionRepository, alcoholCalculator: AlcoholCalculatorRxDecorator) {
        self.sessionRepository = sessionRepository
        self.alcoholCalculator = alcoholCalculator
    }

    func start() {
        sessionRepository.inProgressSession
            .flatMap { self.createNewSessionIfExpired(session: $0) }
            .subscribe(onError: { Logger.w(category: "DATABASE", message: "Auto session closer failed.", error: $0) })
            .disposed(by: disposeBag)
    }

    private func createNewSessionIfExpired(session: Session) -> Completable {
            return alcoholCalculator.calcTimeOfZeroBAC(session: session)
                .flatMapCompletable { (timeOfZeroBAC) -> Completable in
                    if !session.consumptions.isEmpty && dateProvider.currentDate > timeOfZeroBAC {
                        Logger.i(category: "DATABASE", message: "Alcohol is already eliminated. Closing session...")
                        var mutableSession = session
                        mutableSession.inProgress = false
                        return self.sessionRepository.update(session: mutableSession)
                    } else {
                        return Completable.empty()
                    }
            }
        }
}
