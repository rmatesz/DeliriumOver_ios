//
//  SessionFormPresenterImpl.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 08. 25..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SessionFormViewModelImpl: SessionFormViewModel {
    private let sessionRepository: SessionRepository
    let name = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<Sex>(value: Sex.MALE)
    let weight = BehaviorRelay<String>(value: "")
    private let disposeBag = DisposeBag()

    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
        sessionRepository.inProgressSession.subscribe(onNext: { [weak self] session in
            self?.name.accept(session.name)
            self?.gender.accept(session.gender)
            self?.weight.accept(session.weight.removeZerosFromEnd())
        })
        .disposed(by: disposeBag)
    }

    func saveSession() -> Completable {
        return sessionRepository.inProgressSession
            .take(1)
            .asSingle()
            .flatMapCompletable { (session) in
                var updatedSession = session
                updatedSession.name = self.name.value
                updatedSession.weight = Double(self.weight.value) ?? 0.0
                updatedSession.gender = self.gender.value
                return self.sessionRepository.update(session: updatedSession)
        }
    }
}


extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}
