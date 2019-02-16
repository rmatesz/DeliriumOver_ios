// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/ConsumptionRepository.swift at 2019-02-16 19:55:43 +0000

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

    private var __defaultImplStub: ConsumptionRepository?

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    func enableDefaultImplementation(_ stub: ConsumptionRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    // ["name": "delete", "returnSignature": " -> Completable", "fullyQualifiedName": "delete(consumption: Consumption) -> Completable", "parameterSignature": "consumption: Consumption", "parameterSignatureWithoutNames": "consumption: Consumption", "inputTypes": "Consumption", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "consumption", "call": "consumption: consumption", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("consumption"), name: "consumption", type: "Consumption", range: CountableRange(233..<257), nameRange: CountableRange(233..<244))], "returnType": "Completable", "isOptional": false, "escapingParameterNames": "consumption", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func delete(consumption: Consumption)  -> Completable {
        
            return cuckoo_manager.call("delete(consumption: Consumption) -> Completable",
                parameters: (consumption),
                escapingParameters: (consumption),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delete(consumption: consumption))
        
    }
    
    // ["name": "saveConsumption", "returnSignature": " -> Completable", "fullyQualifiedName": "saveConsumption(sessionId: String, consumption: Consumption) -> Completable", "parameterSignature": "sessionId: String, consumption: Consumption", "parameterSignatureWithoutNames": "sessionId: String, consumption: Consumption", "inputTypes": "String, Consumption", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "sessionId, consumption", "call": "sessionId: sessionId, consumption: consumption", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("sessionId"), name: "sessionId", type: "String", range: CountableRange(299..<316), nameRange: CountableRange(299..<308)), CuckooGeneratorFramework.MethodParameter(label: Optional("consumption"), name: "consumption", type: "Consumption", range: CountableRange(318..<342), nameRange: CountableRange(318..<329))], "returnType": "Completable", "isOptional": false, "escapingParameterNames": "sessionId, consumption", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func saveConsumption(sessionId: String, consumption: Consumption)  -> Completable {
        
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
	    func delete<M1: Cuckoo.Matchable>(consumption: M1) -> Cuckoo.__DoNotUse<Completable> where M1.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(Consumption)>] = [wrap(matchable: consumption) { $0 }]
	        return cuckoo_manager.verify("delete(consumption: Consumption) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(sessionId: M1, consumption: M2) -> Cuckoo.__DoNotUse<Completable> where M1.MatchedType == String, M2.MatchedType == Consumption {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Consumption)>] = [wrap(matchable: sessionId) { $0.0 }, wrap(matchable: consumption) { $0.1 }]
	        return cuckoo_manager.verify("saveConsumption(sessionId: String, consumption: Consumption) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class ConsumptionRepositoryStub: ConsumptionRepository {
    

    

    
     func delete(consumption: Consumption)  -> Completable {
        return DefaultValueRegistry.defaultValue(for: Completable.self)
    }
    
     func saveConsumption(sessionId: String, consumption: Consumption)  -> Completable {
        return DefaultValueRegistry.defaultValue(for: Completable.self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/DrinkRepository.swift at 2019-02-16 19:55:43 +0000

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

    private var __defaultImplStub: DrinkRepository?

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    func enableDefaultImplementation(_ stub: DrinkRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    // ["name": "getFrequentlyConsumedDrinks", "returnSignature": " -> Single<[Drink]>", "fullyQualifiedName": "getFrequentlyConsumedDrinks() -> Single<[Drink]>", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Single<[Drink]>", "isOptional": false, "escapingParameterNames": "", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getFrequentlyConsumedDrinks()  -> Single<[Drink]> {
        
            return cuckoo_manager.call("getFrequentlyConsumedDrinks() -> Single<[Drink]>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getFrequentlyConsumedDrinks())
        
    }
    
    // ["name": "getDrinks", "returnSignature": " -> Single<[Drink]>", "fullyQualifiedName": "getDrinks() -> Single<[Drink]>", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Single<[Drink]>", "isOptional": false, "escapingParameterNames": "", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getDrinks()  -> Single<[Drink]> {
        
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
	    
	    
	    func getFrequentlyConsumedDrinks() -> Cuckoo.ProtocolStubFunction<(), Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDrinkRepository.self, method: "getFrequentlyConsumedDrinks() -> Single<[Drink]>", parameterMatchers: matchers))
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
	    func getFrequentlyConsumedDrinks() -> Cuckoo.__DoNotUse<Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getFrequentlyConsumedDrinks() -> Single<[Drink]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getDrinks() -> Cuckoo.__DoNotUse<Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getDrinks() -> Single<[Drink]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class DrinkRepositoryStub: DrinkRepository {
    

    

    
     func getFrequentlyConsumedDrinks()  -> Single<[Drink]> {
        return DefaultValueRegistry.defaultValue(for: Single<[Drink]>.self)
    }
    
     func getDrinks()  -> Single<[Drink]> {
        return DefaultValueRegistry.defaultValue(for: Single<[Drink]>.self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/SessionRepository.swift at 2019-02-16 19:55:43 +0000

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

    private var __defaultImplStub: SessionRepository?

    let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    func enableDefaultImplementation(_ stub: SessionRepository) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    

    

    
    // ["name": "getSessions", "returnSignature": " -> Maybe<[Session]>", "fullyQualifiedName": "getSessions() -> Maybe<[Session]>", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Maybe<[Session]>", "isOptional": false, "escapingParameterNames": "", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getSessions()  -> Maybe<[Session]> {
        
            return cuckoo_manager.call("getSessions() -> Maybe<[Session]>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getSessions())
        
    }
    
    // ["name": "getSession", "returnSignature": " -> Maybe<Session>", "fullyQualifiedName": "getSession(sessionId: String) -> Maybe<Session>", "parameterSignature": "sessionId: String", "parameterSignatureWithoutNames": "sessionId: String", "inputTypes": "String", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "sessionId", "call": "sessionId: sessionId", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("sessionId"), name: "sessionId", type: "String", range: CountableRange(272..<289), nameRange: CountableRange(272..<281))], "returnType": "Maybe<Session>", "isOptional": false, "escapingParameterNames": "sessionId", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getSession(sessionId: String)  -> Maybe<Session> {
        
            return cuckoo_manager.call("getSession(sessionId: String) -> Maybe<Session>",
                parameters: (sessionId),
                escapingParameters: (sessionId),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getSession(sessionId: sessionId))
        
    }
    
    // ["name": "getFriendsSessions", "returnSignature": " -> Observable<[Session]>", "fullyQualifiedName": "getFriendsSessions(shareKey: String) -> Observable<[Session]>", "parameterSignature": "shareKey: String", "parameterSignatureWithoutNames": "shareKey: String", "inputTypes": "String", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "shareKey", "call": "shareKey: shareKey", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("shareKey"), name: "shareKey", type: "String", range: CountableRange(337..<353), nameRange: CountableRange(337..<345))], "returnType": "Observable<[Session]>", "isOptional": false, "escapingParameterNames": "shareKey", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getFriendsSessions(shareKey: String)  -> Observable<[Session]> {
        
            return cuckoo_manager.call("getFriendsSessions(shareKey: String) -> Observable<[Session]>",
                parameters: (shareKey),
                escapingParameters: (shareKey),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getFriendsSessions(shareKey: shareKey))
        
    }
    
    // ["name": "insert", "returnSignature": " -> Completable", "fullyQualifiedName": "insert(session: Session) -> Completable", "parameterSignature": "session: Session", "parameterSignatureWithoutNames": "session: Session", "inputTypes": "Session", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "session", "call": "session: session", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("session"), name: "session", type: "Session", range: CountableRange(396..<412), nameRange: CountableRange(396..<403))], "returnType": "Completable", "isOptional": false, "escapingParameterNames": "session", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func insert(session: Session)  -> Completable {
        
            return cuckoo_manager.call("insert(session: Session) -> Completable",
                parameters: (session),
                escapingParameters: (session),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.insert(session: session))
        
    }
    
    // ["name": "update", "returnSignature": " -> Completable", "fullyQualifiedName": "update(session: Session) -> Completable", "parameterSignature": "session: Session", "parameterSignatureWithoutNames": "session: Session", "inputTypes": "Session", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "session", "call": "session: session", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("session"), name: "session", type: "Session", range: CountableRange(445..<461), nameRange: CountableRange(445..<452))], "returnType": "Completable", "isOptional": false, "escapingParameterNames": "session", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func update(session: Session)  -> Completable {
        
            return cuckoo_manager.call("update(session: Session) -> Completable",
                parameters: (session),
                escapingParameters: (session),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.update(session: session))
        
    }
    
    // ["name": "delete", "returnSignature": " -> Completable", "fullyQualifiedName": "delete(session: Session) -> Completable", "parameterSignature": "session: Session", "parameterSignatureWithoutNames": "session: Session", "inputTypes": "Session", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "session", "call": "session: session", "parameters": [CuckooGeneratorFramework.MethodParameter(label: Optional("session"), name: "session", type: "Session", range: CountableRange(494..<510), nameRange: CountableRange(494..<501))], "returnType": "Completable", "isOptional": false, "escapingParameterNames": "session", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func delete(session: Session)  -> Completable {
        
            return cuckoo_manager.call("delete(session: Session) -> Completable",
                parameters: (session),
                escapingParameters: (session),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.delete(session: session))
        
    }
    
    // ["name": "getInProgressSession", "returnSignature": " -> Maybe<Session>", "fullyQualifiedName": "getInProgressSession() -> Maybe<Session>", "parameterSignature": "", "parameterSignatureWithoutNames": "", "inputTypes": "", "isThrowing": false, "isInit": false, "isOverriding": false, "hasClosureParams": false, "@type": "ProtocolMethod", "accessibility": "", "parameterNames": "", "call": "", "parameters": [], "returnType": "Maybe<Session>", "isOptional": false, "escapingParameterNames": "", "stubFunction": "Cuckoo.ProtocolStubFunction"]
     func getInProgressSession()  -> Maybe<Session> {
        
            return cuckoo_manager.call("getInProgressSession() -> Maybe<Session>",
                parameters: (),
                escapingParameters: (),
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.getInProgressSession())
        
    }
    

	struct __StubbingProxy_SessionRepository: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func getSessions() -> Cuckoo.ProtocolStubFunction<(), Maybe<[Session]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "getSessions() -> Maybe<[Session]>", parameterMatchers: matchers))
	    }
	    
	    func getSession<M1: Cuckoo.Matchable>(sessionId: M1) -> Cuckoo.ProtocolStubFunction<(String), Maybe<Session>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: sessionId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "getSession(sessionId: String) -> Maybe<Session>", parameterMatchers: matchers))
	    }
	    
	    func getFriendsSessions<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "getFriendsSessions(shareKey: String) -> Observable<[Session]>", parameterMatchers: matchers))
	    }
	    
	    func insert<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubFunction<(Session), Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "insert(session: Session) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubFunction<(Session), Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "update(session: Session) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func delete<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ProtocolStubFunction<(Session), Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "delete(session: Session) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func getInProgressSession() -> Cuckoo.ProtocolStubFunction<(), Maybe<Session>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockSessionRepository.self, method: "getInProgressSession() -> Maybe<Session>", parameterMatchers: matchers))
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
	
	    
	
	    
	    @discardableResult
	    func getSessions() -> Cuckoo.__DoNotUse<Maybe<[Session]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getSessions() -> Maybe<[Session]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getSession<M1: Cuckoo.Matchable>(sessionId: M1) -> Cuckoo.__DoNotUse<Maybe<Session>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: sessionId) { $0 }]
	        return cuckoo_manager.verify("getSession(sessionId: String) -> Maybe<Session>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getFriendsSessions<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.__DoNotUse<Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return cuckoo_manager.verify("getFriendsSessions(shareKey: String) -> Observable<[Session]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func insert<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("insert(session: Session) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("update(session: Session) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func delete<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<Completable> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("delete(session: Session) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getInProgressSession() -> Cuckoo.__DoNotUse<Maybe<Session>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getInProgressSession() -> Maybe<Session>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}

}

 class SessionRepositoryStub: SessionRepository {
    

    

    
     func getSessions()  -> Maybe<[Session]> {
        return DefaultValueRegistry.defaultValue(for: Maybe<[Session]>.self)
    }
    
     func getSession(sessionId: String)  -> Maybe<Session> {
        return DefaultValueRegistry.defaultValue(for: Maybe<Session>.self)
    }
    
     func getFriendsSessions(shareKey: String)  -> Observable<[Session]> {
        return DefaultValueRegistry.defaultValue(for: Observable<[Session]>.self)
    }
    
     func insert(session: Session)  -> Completable {
        return DefaultValueRegistry.defaultValue(for: Completable.self)
    }
    
     func update(session: Session)  -> Completable {
        return DefaultValueRegistry.defaultValue(for: Completable.self)
    }
    
     func delete(session: Session)  -> Completable {
        return DefaultValueRegistry.defaultValue(for: Completable.self)
    }
    
     func getInProgressSession()  -> Maybe<Session> {
        return DefaultValueRegistry.defaultValue(for: Maybe<Session>.self)
    }
    
}

