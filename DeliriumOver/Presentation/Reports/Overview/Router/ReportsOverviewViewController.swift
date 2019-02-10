//
//  FirstViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import FirebaseDatabase
import FirebaseAuth
import SwinjectStoryboard

class ReportsOverviewViewController: UIViewController {
    var sessionRepository: SessionRepository?
    var consumptionRepository: ConsumptionRepository?
    var firebaseCommunicator: FirebaseCommunicator?
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let session = Session(title: "test title", description: "description", name: "Test Elek", weight: 85.0, height: 172.5, gender: Sex.MALE, consumptions: [], inProgress: false, shareKey: "")
        sessionRepository!.insert(session: session)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe({_ in
               self.sessionRepository!.getInProgressSession()
                .subscribe({ (observer) in
                        switch observer {
                        case .success(let session):
                            self.consumptionRepository!.saveConsumption(sessionId: session.id, consumption: Consumption(drink: "Sör", quantity: 0.5, unit: DrinkUnit.L, alcohol: 0.052)).subscribe(onCompleted: {
                                print("insert completed")
                            }, onError: { (error) in
                                print("insert error")
                            })
                            self.consumptionRepository!.saveConsumption(sessionId: session.id, consumption: Consumption(drink: "Bor", quantity: 2.0, unit: DrinkUnit.DL, alcohol: 0.12)).subscribe()
                                break
                        case .error: break
                        case .completed: break
                        }
                    })
                 self.sessionRepository!.getSessions().subscribe(onSuccess: { (sessions) in
                    print("sessions loaded")
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        firebaseCommunicator!.loadMinVersionForShare()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe({ (event) in
                switch event {
                    case .success(let version): print("DB min version for share: \(version)")
                    case .error: print("error")
                }
            }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

