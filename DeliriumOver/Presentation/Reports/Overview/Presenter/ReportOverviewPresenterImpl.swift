//
//  ReportOverviewPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import Charts

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
        
        interactor.loadRecords()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe(onNext: { (records) in
                self.update(stats: records)
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
    
    private func update(stats: [Record]) {
        view?.setupChart(stats: stats)
    }
    
    
    //        LineChartDataSet(
    //            stat.data.map { record ->
    //                Entry(
    //                    record.time.time.toFloat(),
    //                    record.bacLevel.toFloat()
    //                )
    //            },
    //            stat.name
    //        )
    //            .apply {
    //                color = COLORS.elementAtOrElse(index) { randomColor() }
    //            }
    
    //    private func randomColor() =
    //        Random().let {
    //            Color.argb(RGB_MAX, it.nextInt(RGB_MAX + 1), it.nextInt(RGB_MAX + 1), it.nextInt(RGB_MAX + 1))
    //        }
}
