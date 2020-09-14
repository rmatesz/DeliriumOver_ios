//
//  SessionListPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class SessionListPresenterImpl: BasePresenter, SessionListPresenter {
    private weak var view: SessionListView?
    private let interactor: SessionListInteractor
    
    init(view: SessionListView, interactor: SessionListInteractor) {
        self.interactor = interactor
        self.view = view
    }
    
    func start() {
        interactor.loadSessions()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (sessions) in
                self.view?.displaySessions(sessions: sessions.map { (session) -> SessionListItem in
                    SessionListItem(title: session.title, inProgress: session.inProgress)
                })
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    

}
