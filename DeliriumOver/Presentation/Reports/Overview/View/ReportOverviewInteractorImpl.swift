//
//  ReportOverviewInteractorImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ReportOverviewInteractorImpl: ReportOverviewInteractor {
    func loadSession() -> Observable<Session> {
        return Observable.empty()
    }
    
    func loadStatistics() -> Observable<Statistics> {
        return Observable.empty()
    }
    
    func saveSession(session: Session) -> Completable {
        return Completable.empty()
    }
    
    
}
