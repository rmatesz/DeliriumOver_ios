//
//  AutoSessionOpener.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 20..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class AutoSessionOpenerImpl {
    private let sessionRepository: SessionRepository
    private let disposeBag = DisposeBag()

    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }

    func start() {
        sessionRepository.sessions
            .flatMap({ (sessions) -> Completable in
                if sessions.filter({ $0.inProgress }).isEmpty {
                    Logger.i(category: "DATABASE", message: "No in progress session found in DB, creating session...")
                    return self.createNewSession(withCloning: sessions.last).asCompletable()
                }
                return Completable.empty()
            })
            .subscribe(onError: { Logger.w(category: "DATABASE", message: "Auto session opener failed. Unable to recover from this error!", error: $0) })
            .disposed(by: disposeBag)
    }

    private func createNewSession(withCloning session: Session? = nil) -> Single<String> {
        guard let session = session else {
            return sessionRepository.insert(session: Session(inProgress: true))
        }
        var newSession = session.clone()
        newSession.inProgress = true
        return sessionRepository.insert(session: newSession)
            .do(onError: { Logger.w(category: "DATABASE", message: "Auto session opener failed.", error: $0) })
            .catchError { _ in Single.never() }
    }
}
