//
//  SessionDAO.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol SessionDAO : DAO {
    func loadAll() -> Observable<[Session]>

    func get(_ sessionId: String) -> Maybe<Session>

    func insert(session: Session) -> Single<String>

    func update(session: Session) -> Completable
}
