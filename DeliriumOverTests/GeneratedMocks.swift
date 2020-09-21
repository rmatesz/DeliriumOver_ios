// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/ConsumptionRepository.swift at 2020-09-21 07:29:52 +0000

//
//  ConsumptionRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 03..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation
import RxSwift


 class MockConsumptionRepository: ConsumptionRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConsumptionRepository
    
     typealias Stubbing = __StubbingProxy_ConsumptionRepository
     typealias Verification = __VerificationProxy_ConsumptionRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConsumptionRepository?

     func enableDefaultImplementation(_ stub: ConsumptionRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func delete(consumption: Consumption) -> Completable {
        
    return cuckoo_manager.call("delete(consumption: Consumption) -> Completable",
            parameters: (consumption),
            escapingParameters: (consumption),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.delete(consumption: consumption))
        
    }
    
    
    
     func saveConsumption(sessionId: String, consumption: Consumption) -> Completable {
        
    return cuckoo_manager.call("saveConsumption(sessionId: String, consumption: Consumption) -> Completable",
            parameters: (sessionId, consumption),
            escapingParameters: (sessionId, consumption),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveConsumption(sessionId: sessionId, consumption: consumption))
        
    }
    

	 struct __StubbingProxy_ConsumptionRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func delete<M1: Cuckoo.Matchable>(consumption: M1) -> Cuckoo.ProtocolStubFunction<(Consumption), Completable> where M1.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(Consumption)>] = [wrap(matchable: consumption) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionRepository.self, method: "delete(consumption: Consumption) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(sessionId: M1, consumption: M2) -> Cuckoo.ProtocolStubFunction<(String, Consumption), Completable> where M1.MatchedType == String, M2.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Consumption)>] = [wrap(matchable: sessionId) { $0.0 }, wrap(matchable: consumption) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionRepository.self, method: "saveConsumption(sessionId: String, consumption: Consumption) -> Completable", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConsumptionRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func delete<M1: Cuckoo.Matchable>(consumption: M1) -> Cuckoo.__DoNotUse<(Consumption), Completable> where M1.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(Consumption)>] = [wrap(matchable: consumption) { $0 }]
	        return cuckoo_manager.verify("delete(consumption: Consumption) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(sessionId: M1, consumption: M2) -> Cuckoo.__DoNotUse<(String, Consumption), Completable> where M1.MatchedType == String, M2.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Consumption)>] = [wrap(matchable: sessionId) { $0.0 }, wrap(matchable: consumption) { $0.1 }]
	        return cuckoo_manager.verify("saveConsumption(sessionId: String, consumption: Consumption) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConsumptionRepositoryStub: ConsumptionRepository {
    

    

    
     func delete(consumption: Consumption) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func saveConsumption(sessionId: String, consumption: Consumption) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/DrinkRepository.swift at 2020-09-21 07:29:52 +0000

//
//  DrinkRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation
import RxSwift


 class MockDrinkRepository: DrinkRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = DrinkRepository
    
     typealias Stubbing = __StubbingProxy_DrinkRepository
     typealias Verification = __VerificationProxy_DrinkRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DrinkRepository?

     func enableDefaultImplementation(_ stub: DrinkRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func getFrequentlyConsumedDrinks() -> Observable<[Drink]> {
        
    return cuckoo_manager.call("getFrequentlyConsumedDrinks() -> Observable<[Drink]>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getFrequentlyConsumedDrinks())
        
    }
    
    
    
     func getDrinks() -> Single<[Drink]> {
        
    return cuckoo_manager.call("getDrinks() -> Single<[Drink]>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getDrinks())
        
    }
    

	 struct __StubbingProxy_DrinkRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getFrequentlyConsumedDrinks() -> Cuckoo.ProtocolStubFunction<(), Observable<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDrinkRepository.self, method: "getFrequentlyConsumedDrinks() -> Observable<[Drink]>", parameterMatchers: matchers))
	    }
	    
	    func getDrinks() -> Cuckoo.ProtocolStubFunction<(), Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDrinkRepository.self, method: "getDrinks() -> Single<[Drink]>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DrinkRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func getFrequentlyConsumedDrinks() -> Cuckoo.__DoNotUse<(), Observable<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getFrequentlyConsumedDrinks() -> Observable<[Drink]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getDrinks() -> Cuckoo.__DoNotUse<(), Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDrinks() -> Single<[Drink]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DrinkRepositoryStub: DrinkRepository {
    

    

    
     func getFrequentlyConsumedDrinks() -> Observable<[Drink]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[Drink]>).self)
    }
    
     func getDrinks() -> Single<[Drink]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[Drink]>).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/SessionRepository.swift at 2020-09-21 07:29:52 +0000

//
//  SessionRepository.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 01..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation
import RxSwift


 class MockSessionRepository: SessionRepository, Cuckoo.ProtocolMock {
    
     typealias MocksType = SessionRepository
    
     typealias Stubbing = __StubbingProxy_SessionRepository
     typealias Verification = __VerificationProxy_SessionRepository

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: SessionRepository?

     func enableDefaultImplementation(_ stub: SessionRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var sessions: Observable<[Session]> {
        get {
            return cuckoo_manager.getter("sessions",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.sessions)
        }
        
    }
    
    
    
     var inProgressSession: Observable<Session> {
        get {
            return cuckoo_manager.getter("inProgressSession",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.inProgressSession)
        }
        
    }
    

    

    
    
    
     func loadSession(sessionId: String) -> Observable<Session> {
        
    return cuckoo_manager.call("loadSession(sessionId: String) -> Observable<Session>",
            parameters: (sessionId),
            escapingParameters: (sessionId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadSession(sessionId: sessionId))
        
    }
    
    
    
     func getFriendsSessions(shareKey: String) -> Observable<[Session]> {
        
    return cuckoo_manager.call("getFriendsSessions(shareKey: String) -> Observable<[Session]>",
            parameters: (shareKey),
            escapingParameters: (shareKey),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getFriendsSessions(shareKey: shareKey))
        
    }
    
    
    
     func insert(session: Session) -> Single<String> {
        
    return cuckoo_manager.call("insert(session: Session) -> Single<String>",
            parameters: (session),
            escapingParameters: (session),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.insert(session: session))
        
    }
    
    
    
     func update(session: Session) -> Completable {
        
    return cuckoo_manager.call("update(session: Session) -> Completable",
            parameters: (session),
            escapingParameters: (session),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.update(session: session))
        
    }
    

	 struct __StubbingProxy_SessionRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var sessions: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockSessionRepository, Observable<[Session]>> {
	        return .init(manager: cuckoo_manager, name: "sessions")
	    }
	    
	    
	    var inProgressSession: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockSessionRepository, Observable<Session>> {
	        return .init(manager: cuckoo_manager, name: "inProgressSession")
	    }
	    
	    
	    func loadSession<M1: Cuckoo.Matchable>(sessionId: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<Session>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: sessionId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "loadSession(sessionId: String) -> Observable<Session>", parameterMatchers: matchers))
	    }
	    
	    func getFriendsSessions<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "getFriendsSessions(shareKey: String) -> Observable<[Session]>", parameterMatchers: matchers))
	    }
	    
	    func insert<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubFunction<(Session), Single<String>> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "insert(session: Session) -> Single<String>", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubFunction<(Session), Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "update(session: Session) -> Completable", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_SessionRepository: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var sessions: Cuckoo.VerifyReadOnlyProperty<Observable<[Session]>> {
	        return .init(manager: cuckoo_manager, name: "sessions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var inProgressSession: Cuckoo.VerifyReadOnlyProperty<Observable<Session>> {
	        return .init(manager: cuckoo_manager, name: "inProgressSession", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func loadSession<M1: Cuckoo.Matchable>(sessionId: M1) -> Cuckoo.__DoNotUse<(String), Observable<Session>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: sessionId) { $0 }]
	        return cuckoo_manager.verify("loadSession(sessionId: String) -> Observable<Session>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getFriendsSessions<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.__DoNotUse<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return cuckoo_manager.verify("getFriendsSessions(shareKey: String) -> Observable<[Session]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func insert<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<(Session), Single<String>> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("insert(session: Session) -> Single<String>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<(Session), Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("update(session: Session) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class SessionRepositoryStub: SessionRepository {
    
    
     var sessions: Observable<[Session]> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Observable<[Session]>).self)
        }
        
    }
    
    
     var inProgressSession: Observable<Session> {
        get {
            return DefaultValueRegistry.defaultValue(for: (Observable<Session>).self)
        }
        
    }
    

    

    
     func loadSession(sessionId: String) -> Observable<Session>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<Session>).self)
    }
    
     func getFriendsSessions(shareKey: String) -> Observable<[Session]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[Session]>).self)
    }
    
     func insert(session: Session) -> Single<String>  {
        return DefaultValueRegistry.defaultValue(for: (Single<String>).self)
    }
    
     func update(session: Session) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
}

