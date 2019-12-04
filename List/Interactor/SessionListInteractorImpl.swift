//
//  SessionListInteractorImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class SessionListInteractorImpl: SessionListInteractor {
    private let sessionRepository: SessionRepository
    
    init(sessionRepository: SessionRepository) {
        self.sessionRepository = sessionRepository
    }
    
    func loadSessions() -> Maybe<[Session]> {
        return sessionRepository.getSessions()
    }
}
