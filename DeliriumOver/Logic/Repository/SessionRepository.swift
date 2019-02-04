//
//  SessionRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 01..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol SessionRepository {
    func getSessions() -> Maybe<[Session]>
    func getSession(sessionId: String) -> Maybe<Session>
    func getFriendsSessions(shareKey: String) -> Observable<[Session]>
    func insert(session: Session) -> Completable
    func update(session: Session) -> Completable
    func delete(session: Session) -> Completable
    func getInProgressSession() -> Maybe<Session>
}