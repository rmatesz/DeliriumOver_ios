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
    func loadAll() -> Observable<[SessionEntity]>

    func getAll() -> Maybe<[SessionEntity]>
    
    func getAllSync() throws -> [SessionEntity]

    func get(_ sessionId: String) -> Maybe<SessionEntity>

    func delete(_ session: SessionEntity) -> Completable

    func deleteSync(_ session: SessionEntity) throws

    func deleteAll() -> Completable
    
    func createEntity() -> SessionEntity
}
