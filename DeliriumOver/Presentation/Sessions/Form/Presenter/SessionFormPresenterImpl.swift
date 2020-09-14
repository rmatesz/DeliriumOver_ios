//
//  SessionFormPresenterImpl.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 08. 25..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class SessionFormViewModelImpl: SessionFormViewModel {
    private let sessionRepository: SessionRepository
    private let nameSubject = BehaviorSubject<String>(value: "")
    private let genderSubject = BehaviorSubject<Sex>(value: Sex.MALE)
    private let weightSubject = BehaviorSubject<Double>(value: 0.0)
    lazy var name: Observable<String> = nameSubject.asObservable()
    lazy var weight: Observable<Double> = weightSubject.asObservable()
    lazy var gender: Observable<Sex> = genderSubject.asObservable()

    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }

    func saveSession(name: String, weight: Double, gender: Sex) -> Completable {
        return sessionRepository.inProgressSession
            .take(1)
            .asSingle()
            .flatMapCompletable { (session) in
                var updatedSession = session
                updatedSession.name = name
                updatedSession.weight = weight
                updatedSession.gender = gender
                return self.sessionRepository.update(session: updatedSession)
        }
    }

}
