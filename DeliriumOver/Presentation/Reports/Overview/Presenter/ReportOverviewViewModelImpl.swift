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
    private let noConsumptionsIntroductions = [OnboardingManager.Onboarding.setupSessionData, .addConsumption]
    private let hasConsumptionsIntroductions = [OnboardingManager.Onboarding.disclaimer, .manageConsumptions]
    private let interactor: ReportOverviewInteractor
    private let onboardingManager: OnboardingManager
    private var session = BehaviorRelay<Session?>(value: nil)
    private var statistics = BehaviorRelay<Statistics?>(value: nil)
    private let disposeBag = DisposeBag()
    let bacLevel = BehaviorRelay<Float>(value: 0)
    let alcoholEliminationDate = BehaviorRelay<Date>(value: Date())
    let sessionTitle = BehaviorRelay<String>(value: "")
    let chartData = BehaviorRelay<[Record]>(value: [])
    let drinks: Observable<[Drink]>
    let onboardingTrigger = BehaviorRelay<[OnboardingManager.Onboarding]>(value: [])

    
    init(interactor: ReportOverviewInteractor, onboardingManager: OnboardingManager) {
        self.interactor = interactor
        self.onboardingManager = onboardingManager
        drinks = interactor.loadFrequentlyConsumedDrinks()

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

        Observable.combineLatest(session, onboardingManager.loadOnboarding(page: .reports))
            .map { [weak self] session, onboarding -> [OnboardingManager.Onboarding] in
                guard let session = session, let strongSelf = self else {
                    return []
                }
                return (session.consumptions.isEmpty ? strongSelf.noConsumptionsIntroductions : strongSelf.hasConsumptionsIntroductions).filter {
                    onboarding.contains($0)
                }
            }
            .distinctUntilChanged()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: onboardingTrigger)
            .disposed(by: disposeBag)
        
        interactor.loadRecords()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .bind(to: chartData)
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

    public func setOnboardingDone(_ onboarding: OnboardingManager.Onboarding) {
        onboardingManager.markFinished(page: .reports, onboarding: onboarding)
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
