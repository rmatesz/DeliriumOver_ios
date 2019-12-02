//
//  ReportOverviewPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class ReportOverviewPresenterImpl: BasePresenter, ReportOverviewPresenter {
    private weak var view: ReportOverviewView?
    private let interactor: ReportOverviewInteractor
    
    private var session: Session? = nil
    
    init(view: ReportOverviewView, interactor: ReportOverviewInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func start() {
        interactor.loadStatistics()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (statistics) in
                self.update(statistics: statistics)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
        
        interactor.loadSession()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (session) in
                self.update(session: session)
            }, onError: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func refresh() {
        
    }
    
    func onTitleEdited(title: String) {
        session?.title = title
        if let session = self.session {
            interactor.saveSession(session: session)
                .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler())
                .subscribe(onCompleted: {
                    // no-op
                }, onError: { (error) in
                    print(error)
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func update(statistics: Statistics) {
        view?.update(bacLevel: Float(statistics.bloodAlcoholConcentration))
        view?.update(alcoholEliminationDate: statistics.alcoholEliminationDate)
    }
    
    private func update(session: Session) {
        self.session = session
        view?.update(sessionTitle: session.title)
    }
}
