//
//  ReportOverviewPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Charts

class ReportOverviewViewModelImpl: ReportOverviewViewModel {
    private let interactor: ReportOverviewInteractor
    private var session = BehaviorRelay<Session?>(value: nil)
    private var statistics = BehaviorRelay<Statistics?>(value: nil)
    private let disposeBag = DisposeBag()
    let bacLevel = BehaviorRelay<Float>(value: 0)
    let alcoholEliminationDate = BehaviorRelay<Date>(value: Date())
    let sessionTitle = BehaviorRelay<String>(value: "")
    let chartData = BehaviorRelay<[Record]>(value: [])
    let drinks = BehaviorRelay<[Drink]>(value: [])
    
    init(interactor: ReportOverviewInteractor) {
        self.interactor = interactor

        interactor.loadStatistics()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: statistics)
            .disposed(by: disposeBag)

        statistics.map { Float($0?.bloodAlcoholConcentration ?? 0) }.bind(to: bacLevel).disposed(by: disposeBag)
        statistics.map { $0?.alcoholEliminationDate ?? Date() }.bind(to: alcoholEliminationDate).disposed(by: disposeBag)
        
        interactor.loadSession()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: session)
            .disposed(by: disposeBag)

        session.map { $0?.title ?? "" }.bind(to: sessionTitle).disposed(by: disposeBag)
        
        interactor.loadRecords()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: chartData)
            .disposed(by: disposeBag)

        interactor.loadFrequentlyConsumedDrinks()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: drinks)
            .disposed(by: disposeBag)
    }
    
    func onTitleEdited(title: String) {
        if var session = self.session.value {
            session.title = title
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


    public func addDrinkAsConsumption(drink: Drink) -> Completable {
        return interactor.add(drink: drink)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
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
