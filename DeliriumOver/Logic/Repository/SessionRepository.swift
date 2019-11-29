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
    func loadSession(sessionId: String) -> Observable<Session>
    func getFriendsSessions(shareKey: String) -> Observable<[Session]>
    func insert(session: Session) -> Single<String>
    func update(session: Session) -> Completable
    func delete(session: Session) -> Completable
    func getInProgressSession() -> Maybe<Session>
    func loadInProgressSession() -> Observable<Session>
}
