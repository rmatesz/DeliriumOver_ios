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

class ReportsOverviewViewController: UIViewController {
    var sessionDAO: SessionDAO
    var sessionRepository: SessionRepository
    var firebaseDatabase: DatabaseReference
    var firebaseSessionDatabase: FirebaseSessionDatabase
    var firebaseAuth: Auth
    var firebaseAuthentication: FirebaseAuthentication
    var firebaseCommunicator: FirebaseCommunicator
    var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        sessionDAO = SessionDAOImpl()
        firebaseDatabase = Database.database().reference()
        firebaseAuth = Auth.auth()
        firebaseSessionDatabase = FirebaseSessionDatabase(firebaseDatabase: firebaseDatabase)
        firebaseAuthentication = FirebaseAuthentication(firebaseAuth: firebaseAuth)
        firebaseCommunicator = FirebaseCommunicator(firebaseSessionDatabase: firebaseSessionDatabase, firebaseAuthentication: firebaseAuthentication)
        sessionRepository = SessionRepositoryImpl(sessionDAO: sessionDAO, firebaseCommunicator: firebaseCommunicator, deviceId: "deviceID")
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let session = Session(title: "test title", description: "description", name: "Test Elek", weight: 85.0, height: 172.5, gender: Sex.MALE, consumptions: [], inProgress: true, deviceId: "12345", shared: false, shareKey: "")
        sessionRepository.insert(session: session)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .subscribe({_ in
                self.sessionRepository.getSessions().subscribe(onSuccess: { (sessions) in
                    print("sessions loaded")
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
        
        firebaseCommunicator.loadMinVersionForShare()
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

