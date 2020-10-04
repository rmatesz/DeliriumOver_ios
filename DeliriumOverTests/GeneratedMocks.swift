// MARK: - Mocks generated from file: DeliriumOver/Logic/Calculations/AlcoholCalculator.swift at 2020-10-04 20:36:32 +0000

//
//  AlcoholCalculator.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation


public class MockAlcoholCalculator: AlcoholCalculator, Cuckoo.ClassMock {
    
    public typealias MocksType = AlcoholCalculator
    
    public typealias Stubbing = __StubbingProxy_AlcoholCalculator
    public typealias Verification = __VerificationProxy_AlcoholCalculator

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: AlcoholCalculator?

    public func enableDefaultImplementation(_ stub: AlcoholCalculator) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public override func calcTimeOfZeroBAC(_ session: Session) -> Date {
        
    return cuckoo_manager.call("calcTimeOfZeroBAC(_: Session) -> Date",
            parameters: (session),
            escapingParameters: (session),
            superclassCall:
                
                super.calcTimeOfZeroBAC(session)
                ,
            defaultCall: __defaultImplStub!.calcTimeOfZeroBAC(session))
        
    }
    
    
    
    public override func calcBloodAlcoholConcentration(session: Session, date: Date) -> Double {
        
    return cuckoo_manager.call("calcBloodAlcoholConcentration(session: Session, date: Date) -> Double",
            parameters: (session, date),
            escapingParameters: (session, date),
            superclassCall:
                
                super.calcBloodAlcoholConcentration(session: session, date: date)
                ,
            defaultCall: __defaultImplStub!.calcBloodAlcoholConcentration(session: session, date: date))
        
    }
    
    
    
    public override func calcAlcoholWeight(quantity: Double, drinkUnit: DrinkUnit, alcohol: Double) -> Double {
        
    return cuckoo_manager.call("calcAlcoholWeight(quantity: Double, drinkUnit: DrinkUnit, alcohol: Double) -> Double",
            parameters: (quantity, drinkUnit, alcohol),
            escapingParameters: (quantity, drinkUnit, alcohol),
            superclassCall:
                
                super.calcAlcoholWeight(quantity: quantity, drinkUnit: drinkUnit, alcohol: alcohol)
                ,
            defaultCall: __defaultImplStub!.calcAlcoholWeight(quantity: quantity, drinkUnit: drinkUnit, alcohol: alcohol))
        
    }
    
    
    
    public override func calcBloodAlcoholConcentration(alcohol: Double, gender: Sex, weight: Double) -> Double {
        
    return cuckoo_manager.call("calcBloodAlcoholConcentration(alcohol: Double, gender: Sex, weight: Double) -> Double",
            parameters: (alcohol, gender, weight),
            escapingParameters: (alcohol, gender, weight),
            superclassCall:
                
                super.calcBloodAlcoholConcentration(alcohol: alcohol, gender: gender, weight: weight)
                ,
            defaultCall: __defaultImplStub!.calcBloodAlcoholConcentration(alcohol: alcohol, gender: gender, weight: weight))
        
    }
    
    
    
    public override func generateRecords(session: Session) -> [RecordData] {
        
    return cuckoo_manager.call("generateRecords(session: Session) -> [RecordData]",
            parameters: (session),
            escapingParameters: (session),
            superclassCall:
                
                super.generateRecords(session: session)
                ,
            defaultCall: __defaultImplStub!.generateRecords(session: session))
        
    }
    

	public struct __StubbingProxy_AlcoholCalculator: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func calcTimeOfZeroBAC<M1: Cuckoo.Matchable>(_ session: M1) -> Cuckoo.ClassStubFunction<(Session), Date> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlcoholCalculator.self, method: "calcTimeOfZeroBAC(_: Session) -> Date", parameterMatchers: matchers))
	    }
	    
	    func calcBloodAlcoholConcentration<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(session: M1, date: M2) -> Cuckoo.ClassStubFunction<(Session, Date), Double> where M1.MatchedType == Session, M2.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Session, Date)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: date) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlcoholCalculator.self, method: "calcBloodAlcoholConcentration(session: Session, date: Date) -> Double", parameterMatchers: matchers))
	    }
	    
	    func calcAlcoholWeight<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(quantity: M1, drinkUnit: M2, alcohol: M3) -> Cuckoo.ClassStubFunction<(Double, DrinkUnit, Double), Double> where M1.MatchedType == Double, M2.MatchedType == DrinkUnit, M3.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DrinkUnit, Double)>] = [wrap(matchable: quantity) { $0.0 }, wrap(matchable: drinkUnit) { $0.1 }, wrap(matchable: alcohol) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlcoholCalculator.self, method: "calcAlcoholWeight(quantity: Double, drinkUnit: DrinkUnit, alcohol: Double) -> Double", parameterMatchers: matchers))
	    }
	    
	    func calcBloodAlcoholConcentration<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(alcohol: M1, gender: M2, weight: M3) -> Cuckoo.ClassStubFunction<(Double, Sex, Double), Double> where M1.MatchedType == Double, M2.MatchedType == Sex, M3.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, Sex, Double)>] = [wrap(matchable: alcohol) { $0.0 }, wrap(matchable: gender) { $0.1 }, wrap(matchable: weight) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlcoholCalculator.self, method: "calcBloodAlcoholConcentration(alcohol: Double, gender: Sex, weight: Double) -> Double", parameterMatchers: matchers))
	    }
	    
	    func generateRecords<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.ClassStubFunction<(Session), [RecordData]> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAlcoholCalculator.self, method: "generateRecords(session: Session) -> [RecordData]", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AlcoholCalculator: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func calcTimeOfZeroBAC<M1: Cuckoo.Matchable>(_ session: M1) -> Cuckoo.__DoNotUse<(Session), Date> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("calcTimeOfZeroBAC(_: Session) -> Date", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func calcBloodAlcoholConcentration<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(session: M1, date: M2) -> Cuckoo.__DoNotUse<(Session, Date), Double> where M1.MatchedType == Session, M2.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Session, Date)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: date) { $0.1 }]
	        return cuckoo_manager.verify("calcBloodAlcoholConcentration(session: Session, date: Date) -> Double", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func calcAlcoholWeight<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(quantity: M1, drinkUnit: M2, alcohol: M3) -> Cuckoo.__DoNotUse<(Double, DrinkUnit, Double), Double> where M1.MatchedType == Double, M2.MatchedType == DrinkUnit, M3.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, DrinkUnit, Double)>] = [wrap(matchable: quantity) { $0.0 }, wrap(matchable: drinkUnit) { $0.1 }, wrap(matchable: alcohol) { $0.2 }]
	        return cuckoo_manager.verify("calcAlcoholWeight(quantity: Double, drinkUnit: DrinkUnit, alcohol: Double) -> Double", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func calcBloodAlcoholConcentration<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(alcohol: M1, gender: M2, weight: M3) -> Cuckoo.__DoNotUse<(Double, Sex, Double), Double> where M1.MatchedType == Double, M2.MatchedType == Sex, M3.MatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double, Sex, Double)>] = [wrap(matchable: alcohol) { $0.0 }, wrap(matchable: gender) { $0.1 }, wrap(matchable: weight) { $0.2 }]
	        return cuckoo_manager.verify("calcBloodAlcoholConcentration(alcohol: Double, gender: Sex, weight: Double) -> Double", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func generateRecords<M1: Cuckoo.Matchable>(session: M1) -> Cuckoo.__DoNotUse<(Session), [RecordData]> where M1.MatchedType == Session {
	        let matchers: [Cuckoo.ParameterMatcher<(Session)>] = [wrap(matchable: session) { $0 }]
	        return cuckoo_manager.verify("generateRecords(session: Session) -> [RecordData]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AlcoholCalculatorStub: AlcoholCalculator {
    

    

    
    public override func calcTimeOfZeroBAC(_ session: Session) -> Date  {
        return DefaultValueRegistry.defaultValue(for: (Date).self)
    }
    
    public override func calcBloodAlcoholConcentration(session: Session, date: Date) -> Double  {
        return DefaultValueRegistry.defaultValue(for: (Double).self)
    }
    
    public override func calcAlcoholWeight(quantity: Double, drinkUnit: DrinkUnit, alcohol: Double) -> Double  {
        return DefaultValueRegistry.defaultValue(for: (Double).self)
    }
    
    public override func calcBloodAlcoholConcentration(alcohol: Double, gender: Sex, weight: Double) -> Double  {
        return DefaultValueRegistry.defaultValue(for: (Double).self)
    }
    
    public override func generateRecords(session: Session) -> [RecordData]  {
        return DefaultValueRegistry.defaultValue(for: ([RecordData]).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/DB/CoreData/CoreDataAdapter.swift at 2020-10-04 20:36:32 +0000

//
//  CodeDataAdapter.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import CoreData
import Foundation
import RxSwift


 class MockCoreDataAdapter: CoreDataAdapter, Cuckoo.ProtocolMock {
    
     typealias MocksType = CoreDataAdapter
    
     typealias Stubbing = __StubbingProxy_CoreDataAdapter
     typealias Verification = __VerificationProxy_CoreDataAdapter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CoreDataAdapter?

     func enableDefaultImplementation(_ stub: CoreDataAdapter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject> {
        
    return cuckoo_manager.call("insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>",
            parameters: (entityName, context),
            escapingParameters: (entityName, context),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.insertNewObject(forEntityName: entityName, into: context))
        
    }
    

	 struct __StubbingProxy_CoreDataAdapter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func insertNewObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(forEntityName entityName: M1, into context: M2) -> Cuckoo.ProtocolStubFunction<(String, NSManagedObjectContext), Single<NSManagedObject>> where M1.MatchedType == String, M2.MatchedType == NSManagedObjectContext {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSManagedObjectContext)>] = [wrap(matchable: entityName) { $0.0 }, wrap(matchable: context) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataAdapter.self, method: "insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CoreDataAdapter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func insertNewObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(forEntityName entityName: M1, into context: M2) -> Cuckoo.__DoNotUse<(String, NSManagedObjectContext), Single<NSManagedObject>> where M1.MatchedType == String, M2.MatchedType == NSManagedObjectContext {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSManagedObjectContext)>] = [wrap(matchable: entityName) { $0.0 }, wrap(matchable: context) { $0.1 }]
	        return cuckoo_manager.verify("insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CoreDataAdapterStub: CoreDataAdapter {
    

    

    
     func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject>  {
        return DefaultValueRegistry.defaultValue(for: (Single<NSManagedObject>).self)
    }
    
}



 class MockCoreDataAdapterImpl: CoreDataAdapterImpl, Cuckoo.ClassMock {
    
     typealias MocksType = CoreDataAdapterImpl
    
     typealias Stubbing = __StubbingProxy_CoreDataAdapterImpl
     typealias Verification = __VerificationProxy_CoreDataAdapterImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: CoreDataAdapterImpl?

     func enableDefaultImplementation(_ stub: CoreDataAdapterImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject> {
        
    return cuckoo_manager.call("insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>",
            parameters: (entityName, context),
            escapingParameters: (entityName, context),
            superclassCall:
                
                super.insertNewObject(forEntityName: entityName, into: context)
                ,
            defaultCall: __defaultImplStub!.insertNewObject(forEntityName: entityName, into: context))
        
    }
    

	 struct __StubbingProxy_CoreDataAdapterImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func insertNewObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(forEntityName entityName: M1, into context: M2) -> Cuckoo.ClassStubFunction<(String, NSManagedObjectContext), Single<NSManagedObject>> where M1.MatchedType == String, M2.MatchedType == NSManagedObjectContext {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSManagedObjectContext)>] = [wrap(matchable: entityName) { $0.0 }, wrap(matchable: context) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCoreDataAdapterImpl.self, method: "insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CoreDataAdapterImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func insertNewObject<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(forEntityName entityName: M1, into context: M2) -> Cuckoo.__DoNotUse<(String, NSManagedObjectContext), Single<NSManagedObject>> where M1.MatchedType == String, M2.MatchedType == NSManagedObjectContext {
	        let matchers: [Cuckoo.ParameterMatcher<(String, NSManagedObjectContext)>] = [wrap(matchable: entityName) { $0.0 }, wrap(matchable: context) { $0.1 }]
	        return cuckoo_manager.verify("insertNewObject(forEntityName: String, into: NSManagedObjectContext) -> Single<NSManagedObject>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CoreDataAdapterImplStub: CoreDataAdapterImpl {
    

    

    
     override func insertNewObject(forEntityName entityName: String, into context: NSManagedObjectContext) -> Single<NSManagedObject>  {
        return DefaultValueRegistry.defaultValue(for: (Single<NSManagedObject>).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/DB/Firebase/FirebaseAuthentication.swift at 2020-10-04 20:36:32 +0000

//
//  FirebaseAuthentication.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Firebase
import FirebaseAuth
import Foundation
import RxSwift


 class MockFirebaseAuthentication: FirebaseAuthentication, Cuckoo.ProtocolMock {
    
     typealias MocksType = FirebaseAuthentication
    
     typealias Stubbing = __StubbingProxy_FirebaseAuthentication
     typealias Verification = __VerificationProxy_FirebaseAuthentication

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FirebaseAuthentication?

     func enableDefaultImplementation(_ stub: FirebaseAuthentication) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func authenticate() -> Single<User> {
        
    return cuckoo_manager.call("authenticate() -> Single<User>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.authenticate())
        
    }
    

	 struct __StubbingProxy_FirebaseAuthentication: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func authenticate() -> Cuckoo.ProtocolStubFunction<(), Single<User>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseAuthentication.self, method: "authenticate() -> Single<User>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseAuthentication: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func authenticate() -> Cuckoo.__DoNotUse<(), Single<User>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("authenticate() -> Single<User>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseAuthenticationStub: FirebaseAuthentication {
    

    

    
     func authenticate() -> Single<User>  {
        return DefaultValueRegistry.defaultValue(for: (Single<User>).self)
    }
    
}



 class MockFirebaseAuthenticationImpl: FirebaseAuthenticationImpl, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseAuthenticationImpl
    
     typealias Stubbing = __StubbingProxy_FirebaseAuthenticationImpl
     typealias Verification = __VerificationProxy_FirebaseAuthenticationImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseAuthenticationImpl?

     func enableDefaultImplementation(_ stub: FirebaseAuthenticationImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func authenticate() -> Single<User> {
        
    return cuckoo_manager.call("authenticate() -> Single<User>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.authenticate()
                ,
            defaultCall: __defaultImplStub!.authenticate())
        
    }
    

	 struct __StubbingProxy_FirebaseAuthenticationImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func authenticate() -> Cuckoo.ClassStubFunction<(), Single<User>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseAuthenticationImpl.self, method: "authenticate() -> Single<User>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseAuthenticationImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func authenticate() -> Cuckoo.__DoNotUse<(), Single<User>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("authenticate() -> Single<User>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseAuthenticationImplStub: FirebaseAuthenticationImpl {
    

    

    
     override func authenticate() -> Single<User>  {
        return DefaultValueRegistry.defaultValue(for: (Single<User>).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/DB/Firebase/FirebaseSessionDatabase.swift at 2020-10-04 20:36:32 +0000

//
//  FirebaseSessionDatabase.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 07..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import FirebaseDatabase
import Foundation
import RxSwift


 class MockFirebaseSessionDatabase: FirebaseSessionDatabase, Cuckoo.ProtocolMock {
    
     typealias MocksType = FirebaseSessionDatabase
    
     typealias Stubbing = __StubbingProxy_FirebaseSessionDatabase
     typealias Verification = __VerificationProxy_FirebaseSessionDatabase

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FirebaseSessionDatabase?

     func enableDefaultImplementation(_ stub: FirebaseSessionDatabase) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func loadData(shareKey: String) -> Observable<[Session]> {
        
    return cuckoo_manager.call("loadData(shareKey: String) -> Observable<[Session]>",
            parameters: (shareKey),
            escapingParameters: (shareKey),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadData(shareKey: shareKey))
        
    }
    
    
    
     func update(session: Session?, shareKey: String, userId: String) -> Completable {
        
    return cuckoo_manager.call("update(session: Session?, shareKey: String, userId: String) -> Completable",
            parameters: (session, shareKey, userId),
            escapingParameters: (session, shareKey, userId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.update(session: session, shareKey: shareKey, userId: userId))
        
    }
    
    
    
     func getMinVersionForShare() -> Single<Int> {
        
    return cuckoo_manager.call("getMinVersionForShare() -> Single<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.getMinVersionForShare())
        
    }
    

	 struct __StubbingProxy_FirebaseSessionDatabase: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func loadData<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabase.self, method: "loadData(shareKey: String) -> Observable<[Session]>", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(session: M1, shareKey: M2, userId: M3) -> Cuckoo.ProtocolStubFunction<(Session?, String, String), Completable> where M1.OptionalMatchedType == Session, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Session?, String, String)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: shareKey) { $0.1 }, wrap(matchable: userId) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabase.self, method: "update(session: Session?, shareKey: String, userId: String) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func getMinVersionForShare() -> Cuckoo.ProtocolStubFunction<(), Single<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabase.self, method: "getMinVersionForShare() -> Single<Int>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseSessionDatabase: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func loadData<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.__DoNotUse<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return cuckoo_manager.verify("loadData(shareKey: String) -> Observable<[Session]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(session: M1, shareKey: M2, userId: M3) -> Cuckoo.__DoNotUse<(Session?, String, String), Completable> where M1.OptionalMatchedType == Session, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Session?, String, String)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: shareKey) { $0.1 }, wrap(matchable: userId) { $0.2 }]
	        return cuckoo_manager.verify("update(session: Session?, shareKey: String, userId: String) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMinVersionForShare() -> Cuckoo.__DoNotUse<(), Single<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getMinVersionForShare() -> Single<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseSessionDatabaseStub: FirebaseSessionDatabase {
    

    

    
     func loadData(shareKey: String) -> Observable<[Session]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[Session]>).self)
    }
    
     func update(session: Session?, shareKey: String, userId: String) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func getMinVersionForShare() -> Single<Int>  {
        return DefaultValueRegistry.defaultValue(for: (Single<Int>).self)
    }
    
}



 class MockFirebaseSessionDatabaseImpl: FirebaseSessionDatabaseImpl, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseSessionDatabaseImpl
    
     typealias Stubbing = __StubbingProxy_FirebaseSessionDatabaseImpl
     typealias Verification = __VerificationProxy_FirebaseSessionDatabaseImpl

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseSessionDatabaseImpl?

     func enableDefaultImplementation(_ stub: FirebaseSessionDatabaseImpl) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func loadData(shareKey: String) -> Observable<[Session]> {
        
    return cuckoo_manager.call("loadData(shareKey: String) -> Observable<[Session]>",
            parameters: (shareKey),
            escapingParameters: (shareKey),
            superclassCall:
                
                super.loadData(shareKey: shareKey)
                ,
            defaultCall: __defaultImplStub!.loadData(shareKey: shareKey))
        
    }
    
    
    
     override func update(session: Session?, shareKey: String, userId: String) -> Completable {
        
    return cuckoo_manager.call("update(session: Session?, shareKey: String, userId: String) -> Completable",
            parameters: (session, shareKey, userId),
            escapingParameters: (session, shareKey, userId),
            superclassCall:
                
                super.update(session: session, shareKey: shareKey, userId: userId)
                ,
            defaultCall: __defaultImplStub!.update(session: session, shareKey: shareKey, userId: userId))
        
    }
    
    
    
     override func getMinVersionForShare() -> Single<Int> {
        
    return cuckoo_manager.call("getMinVersionForShare() -> Single<Int>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.getMinVersionForShare()
                ,
            defaultCall: __defaultImplStub!.getMinVersionForShare())
        
    }
    

	 struct __StubbingProxy_FirebaseSessionDatabaseImpl: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func loadData<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.ClassStubFunction<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabaseImpl.self, method: "loadData(shareKey: String) -> Observable<[Session]>", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(session: M1, shareKey: M2, userId: M3) -> Cuckoo.ClassStubFunction<(Session?, String, String), Completable> where M1.OptionalMatchedType == Session, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Session?, String, String)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: shareKey) { $0.1 }, wrap(matchable: userId) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabaseImpl.self, method: "update(session: Session?, shareKey: String, userId: String) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func getMinVersionForShare() -> Cuckoo.ClassStubFunction<(), Single<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseSessionDatabaseImpl.self, method: "getMinVersionForShare() -> Single<Int>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseSessionDatabaseImpl: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func loadData<M1: Cuckoo.Matchable>(shareKey: M1) -> Cuckoo.__DoNotUse<(String), Observable<[Session]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: shareKey) { $0 }]
	        return cuckoo_manager.verify("loadData(shareKey: String) -> Observable<[Session]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(session: M1, shareKey: M2, userId: M3) -> Cuckoo.__DoNotUse<(Session?, String, String), Completable> where M1.OptionalMatchedType == Session, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(Session?, String, String)>] = [wrap(matchable: session) { $0.0 }, wrap(matchable: shareKey) { $0.1 }, wrap(matchable: userId) { $0.2 }]
	        return cuckoo_manager.verify("update(session: Session?, shareKey: String, userId: String) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func getMinVersionForShare() -> Cuckoo.__DoNotUse<(), Single<Int>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("getMinVersionForShare() -> Single<Int>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseSessionDatabaseImplStub: FirebaseSessionDatabaseImpl {
    

    

    
     override func loadData(shareKey: String) -> Observable<[Session]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[Session]>).self)
    }
    
     override func update(session: Session?, shareKey: String, userId: String) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     override func getMinVersionForShare() -> Single<Int>  {
        return DefaultValueRegistry.defaultValue(for: (Single<Int>).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/ConsumptionRepository.swift at 2020-10-04 20:36:32 +0000

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


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/DrinkRepository.swift at 2020-10-04 20:36:32 +0000

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


// MARK: - Mocks generated from file: DeliriumOver/Logic/Repository/SessionRepository.swift at 2020-10-04 20:36:32 +0000

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


// MARK: - Mocks generated from file: DeliriumOver/Presentation/Consumptions/Form/Interactor/ConsumptionFormInteractor.swift at 2020-10-04 20:36:32 +0000

//
//  ConsumptionFormInteractor.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation
import RxSwift


 class MockConsumptionFormInteractor: ConsumptionFormInteractor, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConsumptionFormInteractor
    
     typealias Stubbing = __StubbingProxy_ConsumptionFormInteractor
     typealias Verification = __VerificationProxy_ConsumptionFormInteractor

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConsumptionFormInteractor?

     func enableDefaultImplementation(_ stub: ConsumptionFormInteractor) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func loadDrinks() -> Single<[Drink]> {
        
    return cuckoo_manager.call("loadDrinks() -> Single<[Drink]>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadDrinks())
        
    }
    
    
    
     func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable {
        
    return cuckoo_manager.call("saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable",
            parameters: (drink, alcohol, quantity, unit),
            escapingParameters: (drink, alcohol, quantity, unit),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveConsumption(drink: drink, alcohol: alcohol, quantity: quantity, unit: unit))
        
    }
    
    
    
     func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable {
        
    return cuckoo_manager.call("saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable",
            parameters: (drink, alcohol, quantity, unit, date),
            escapingParameters: (drink, alcohol, quantity, unit, date),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.saveConsumption(drink: drink, alcohol: alcohol, quantity: quantity, unit: unit, date: date))
        
    }
    
    
    
     func validateDrink(drink: String) -> ConsumptionFormValidationResult {
        
    return cuckoo_manager.call("validateDrink(drink: String) -> ConsumptionFormValidationResult",
            parameters: (drink),
            escapingParameters: (drink),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validateDrink(drink: drink))
        
    }
    
    
    
     func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult {
        
    return cuckoo_manager.call("validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult",
            parameters: (alcohol),
            escapingParameters: (alcohol),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validateAlcohol(alcohol: alcohol))
        
    }
    
    
    
     func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult {
        
    return cuckoo_manager.call("validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult",
            parameters: (quantity),
            escapingParameters: (quantity),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validateQuantity(quantity: quantity))
        
    }
    
    
    
     func resolveDate(currentDate: Date, newDate: Date) -> Date {
        
    return cuckoo_manager.call("resolveDate(currentDate: Date, newDate: Date) -> Date",
            parameters: (currentDate, newDate),
            escapingParameters: (currentDate, newDate),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.resolveDate(currentDate: currentDate, newDate: newDate))
        
    }
    

	 struct __StubbingProxy_ConsumptionFormInteractor: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func loadDrinks() -> Cuckoo.ProtocolStubFunction<(), Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "loadDrinks() -> Single<[Drink]>", parameterMatchers: matchers))
	    }
	    
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(drink: M1, alcohol: M2, quantity: M3, unit: M4) -> Cuckoo.ProtocolStubFunction<(String, Double, Double, DrinkUnit), Completable> where M1.MatchedType == String, M2.MatchedType == Double, M3.MatchedType == Double, M4.MatchedType == DrinkUnit {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Double, Double, DrinkUnit)>] = [wrap(matchable: drink) { $0.0 }, wrap(matchable: alcohol) { $0.1 }, wrap(matchable: quantity) { $0.2 }, wrap(matchable: unit) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable, M5: Cuckoo.Matchable>(drink: M1, alcohol: M2, quantity: M3, unit: M4, date: M5) -> Cuckoo.ProtocolStubFunction<(String, Double, Double, DrinkUnit, Date), Completable> where M1.MatchedType == String, M2.MatchedType == Double, M3.MatchedType == Double, M4.MatchedType == DrinkUnit, M5.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Double, Double, DrinkUnit, Date)>] = [wrap(matchable: drink) { $0.0 }, wrap(matchable: alcohol) { $0.1 }, wrap(matchable: quantity) { $0.2 }, wrap(matchable: unit) { $0.3 }, wrap(matchable: date) { $0.4 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func validateDrink<M1: Cuckoo.Matchable>(drink: M1) -> Cuckoo.ProtocolStubFunction<(String), ConsumptionFormValidationResult> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: drink) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "validateDrink(drink: String) -> ConsumptionFormValidationResult", parameterMatchers: matchers))
	    }
	    
	    func validateAlcohol<M1: Cuckoo.OptionalMatchable>(alcohol: M1) -> Cuckoo.ProtocolStubFunction<(Double?), ConsumptionFormValidationResult> where M1.OptionalMatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double?)>] = [wrap(matchable: alcohol) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult", parameterMatchers: matchers))
	    }
	    
	    func validateQuantity<M1: Cuckoo.OptionalMatchable>(quantity: M1) -> Cuckoo.ProtocolStubFunction<(Double?), ConsumptionFormValidationResult> where M1.OptionalMatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double?)>] = [wrap(matchable: quantity) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult", parameterMatchers: matchers))
	    }
	    
	    func resolveDate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(currentDate: M1, newDate: M2) -> Cuckoo.ProtocolStubFunction<(Date, Date), Date> where M1.MatchedType == Date, M2.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Date)>] = [wrap(matchable: currentDate) { $0.0 }, wrap(matchable: newDate) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormInteractor.self, method: "resolveDate(currentDate: Date, newDate: Date) -> Date", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConsumptionFormInteractor: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func loadDrinks() -> Cuckoo.__DoNotUse<(), Single<[Drink]>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadDrinks() -> Single<[Drink]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable>(drink: M1, alcohol: M2, quantity: M3, unit: M4) -> Cuckoo.__DoNotUse<(String, Double, Double, DrinkUnit), Completable> where M1.MatchedType == String, M2.MatchedType == Double, M3.MatchedType == Double, M4.MatchedType == DrinkUnit {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Double, Double, DrinkUnit)>] = [wrap(matchable: drink) { $0.0 }, wrap(matchable: alcohol) { $0.1 }, wrap(matchable: quantity) { $0.2 }, wrap(matchable: unit) { $0.3 }]
	        return cuckoo_manager.verify("saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func saveConsumption<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.Matchable, M5: Cuckoo.Matchable>(drink: M1, alcohol: M2, quantity: M3, unit: M4, date: M5) -> Cuckoo.__DoNotUse<(String, Double, Double, DrinkUnit, Date), Completable> where M1.MatchedType == String, M2.MatchedType == Double, M3.MatchedType == Double, M4.MatchedType == DrinkUnit, M5.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Double, Double, DrinkUnit, Date)>] = [wrap(matchable: drink) { $0.0 }, wrap(matchable: alcohol) { $0.1 }, wrap(matchable: quantity) { $0.2 }, wrap(matchable: unit) { $0.3 }, wrap(matchable: date) { $0.4 }]
	        return cuckoo_manager.verify("saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func validateDrink<M1: Cuckoo.Matchable>(drink: M1) -> Cuckoo.__DoNotUse<(String), ConsumptionFormValidationResult> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: drink) { $0 }]
	        return cuckoo_manager.verify("validateDrink(drink: String) -> ConsumptionFormValidationResult", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func validateAlcohol<M1: Cuckoo.OptionalMatchable>(alcohol: M1) -> Cuckoo.__DoNotUse<(Double?), ConsumptionFormValidationResult> where M1.OptionalMatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double?)>] = [wrap(matchable: alcohol) { $0 }]
	        return cuckoo_manager.verify("validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func validateQuantity<M1: Cuckoo.OptionalMatchable>(quantity: M1) -> Cuckoo.__DoNotUse<(Double?), ConsumptionFormValidationResult> where M1.OptionalMatchedType == Double {
	        let matchers: [Cuckoo.ParameterMatcher<(Double?)>] = [wrap(matchable: quantity) { $0 }]
	        return cuckoo_manager.verify("validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func resolveDate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(currentDate: M1, newDate: M2) -> Cuckoo.__DoNotUse<(Date, Date), Date> where M1.MatchedType == Date, M2.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date, Date)>] = [wrap(matchable: currentDate) { $0.0 }, wrap(matchable: newDate) { $0.1 }]
	        return cuckoo_manager.verify("resolveDate(currentDate: Date, newDate: Date) -> Date", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConsumptionFormInteractorStub: ConsumptionFormInteractor {
    

    

    
     func loadDrinks() -> Single<[Drink]>  {
        return DefaultValueRegistry.defaultValue(for: (Single<[Drink]>).self)
    }
    
     func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func saveConsumption(drink: String, alcohol: Double, quantity: Double, unit: DrinkUnit, date: Date) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func validateDrink(drink: String) -> ConsumptionFormValidationResult  {
        return DefaultValueRegistry.defaultValue(for: (ConsumptionFormValidationResult).self)
    }
    
     func validateAlcohol(alcohol: Double?) -> ConsumptionFormValidationResult  {
        return DefaultValueRegistry.defaultValue(for: (ConsumptionFormValidationResult).self)
    }
    
     func validateQuantity(quantity: Double?) -> ConsumptionFormValidationResult  {
        return DefaultValueRegistry.defaultValue(for: (ConsumptionFormValidationResult).self)
    }
    
     func resolveDate(currentDate: Date, newDate: Date) -> Date  {
        return DefaultValueRegistry.defaultValue(for: (Date).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Presentation/Consumptions/Form/Router/ConsumptionFormRouter.swift at 2020-10-04 20:36:32 +0000

//
//  ConsumptionFormRouter.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 08. 26..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation


 class MockConsumptionFormRouter: ConsumptionFormRouter, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConsumptionFormRouter
    
     typealias Stubbing = __StubbingProxy_ConsumptionFormRouter
     typealias Verification = __VerificationProxy_ConsumptionFormRouter

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConsumptionFormRouter?

     func enableDefaultImplementation(_ stub: ConsumptionFormRouter) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func finish()  {
        
    return cuckoo_manager.call("finish()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.finish())
        
    }
    

	 struct __StubbingProxy_ConsumptionFormRouter: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func finish() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormRouter.self, method: "finish()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConsumptionFormRouter: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func finish() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("finish()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConsumptionFormRouterStub: ConsumptionFormRouter {
    

    

    
     func finish()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Presentation/Consumptions/Form/View/ConsumptionFormView.swift at 2020-10-04 20:36:32 +0000

//
//  ConsumptionFormView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation


 class MockConsumptionFormView: ConsumptionFormView, Cuckoo.ProtocolMock {
    
     typealias MocksType = ConsumptionFormView
    
     typealias Stubbing = __StubbingProxy_ConsumptionFormView
     typealias Verification = __VerificationProxy_ConsumptionFormView

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ConsumptionFormView?

     func enableDefaultImplementation(_ stub: ConsumptionFormView) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var saveIsEnabled: Bool {
        get {
            return cuckoo_manager.getter("saveIsEnabled",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.saveIsEnabled)
        }
        
        set {
            cuckoo_manager.setter("saveIsEnabled",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.saveIsEnabled = newValue)
        }
        
    }
    

    

    
    
    
     func updateTime(_ time: Date)  {
        
    return cuckoo_manager.call("updateTime(_: Date)",
            parameters: (time),
            escapingParameters: (time),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updateTime(time))
        
    }
    
    
    
     func showDrinkError(_ error: String)  {
        
    return cuckoo_manager.call("showDrinkError(_: String)",
            parameters: (error),
            escapingParameters: (error),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.showDrinkError(error))
        
    }
    
    
    
     func hideDrinkError()  {
        
    return cuckoo_manager.call("hideDrinkError()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.hideDrinkError())
        
    }
    

	 struct __StubbingProxy_ConsumptionFormView: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var saveIsEnabled: Cuckoo.ProtocolToBeStubbedProperty<MockConsumptionFormView, Bool> {
	        return .init(manager: cuckoo_manager, name: "saveIsEnabled")
	    }
	    
	    
	    func updateTime<M1: Cuckoo.Matchable>(_ time: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Date)> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: time) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormView.self, method: "updateTime(_: Date)", parameterMatchers: matchers))
	    }
	    
	    func showDrinkError<M1: Cuckoo.Matchable>(_ error: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: error) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormView.self, method: "showDrinkError(_: String)", parameterMatchers: matchers))
	    }
	    
	    func hideDrinkError() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockConsumptionFormView.self, method: "hideDrinkError()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ConsumptionFormView: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var saveIsEnabled: Cuckoo.VerifyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "saveIsEnabled", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func updateTime<M1: Cuckoo.Matchable>(_ time: M1) -> Cuckoo.__DoNotUse<(Date), Void> where M1.MatchedType == Date {
	        let matchers: [Cuckoo.ParameterMatcher<(Date)>] = [wrap(matchable: time) { $0 }]
	        return cuckoo_manager.verify("updateTime(_: Date)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func showDrinkError<M1: Cuckoo.Matchable>(_ error: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: error) { $0 }]
	        return cuckoo_manager.verify("showDrinkError(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func hideDrinkError() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("hideDrinkError()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ConsumptionFormViewStub: ConsumptionFormView {
    
    
     var saveIsEnabled: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
        set { }
        
    }
    

    

    
     func updateTime(_ time: Date)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func showDrinkError(_ error: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func hideDrinkError()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


// MARK: - Mocks generated from file: DeliriumOver/Util/Date/DateProvider.swift at 2020-10-04 20:36:32 +0000

//
//  DateProvider.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 30..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import Foundation


public class MockDateProvider: DateProvider, Cuckoo.ProtocolMock {
    
    public typealias MocksType = DateProvider
    
    public typealias Stubbing = __StubbingProxy_DateProvider
    public typealias Verification = __VerificationProxy_DateProvider

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DateProvider?

    public func enableDefaultImplementation(_ stub: DateProvider) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var currentDate: Date {
        get {
            return cuckoo_manager.getter("currentDate",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.currentDate)
        }
        
    }
    

    

    

	public struct __StubbingProxy_DateProvider: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var currentDate: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDateProvider, Date> {
	        return .init(manager: cuckoo_manager, name: "currentDate")
	    }
	    
	    
	}

	public struct __VerificationProxy_DateProvider: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var currentDate: Cuckoo.VerifyReadOnlyProperty<Date> {
	        return .init(manager: cuckoo_manager, name: "currentDate", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class DateProviderStub: DateProvider {
    
    
    public var currentDate: Date {
        get {
            return DefaultValueRegistry.defaultValue(for: (Date).self)
        }
        
    }
    

    

    
}


// MARK: - Mocks generated from file: DeliriumOverTests/TestUtils/Mock/CoreData.swift at 2020-10-04 20:36:32 +0000

//
//  MockNSManagedObjectContext.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 30..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import CoreData
import DeliriumOver
import Foundation


 class MockManagedObjectContext: ManagedObjectContext, Cuckoo.ClassMock {
    
     typealias MocksType = ManagedObjectContext
    
     typealias Stubbing = __StubbingProxy_ManagedObjectContext
     typealias Verification = __VerificationProxy_ManagedObjectContext

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ManagedObjectContext?

     func enableDefaultImplementation(_ stub: ManagedObjectContext) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get {
            return cuckoo_manager.getter("persistentStoreCoordinator",
                superclassCall:
                    
                    super.persistentStoreCoordinator
                    ,
                defaultCall: __defaultImplStub!.persistentStoreCoordinator)
        }
        
        set {
            cuckoo_manager.setter("persistentStoreCoordinator",
                value: newValue,
                superclassCall:
                    
                    super.persistentStoreCoordinator = newValue
                    ,
                defaultCall: __defaultImplStub!.persistentStoreCoordinator = newValue)
        }
        
    }
    

    

    
    
    
     override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any] {
        
    return try cuckoo_manager.callThrows("fetch(_: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]",
            parameters: (request),
            escapingParameters: (request),
            superclassCall:
                
                super.fetch(request)
                ,
            defaultCall: __defaultImplStub!.fetch(request))
        
    }
    
    
    
     override func existingObject(with objectID: NSManagedObjectID) throws -> NSManagedObject {
        
    return try cuckoo_manager.callThrows("existingObject(with: NSManagedObjectID) throws -> NSManagedObject",
            parameters: (objectID),
            escapingParameters: (objectID),
            superclassCall:
                
                super.existingObject(with: objectID)
                ,
            defaultCall: __defaultImplStub!.existingObject(with: objectID))
        
    }
    
    
    
     override func insert(_ object: NSManagedObject)  {
        
    return cuckoo_manager.call("insert(_: NSManagedObject)",
            parameters: (object),
            escapingParameters: (object),
            superclassCall:
                
                super.insert(object)
                ,
            defaultCall: __defaultImplStub!.insert(object))
        
    }
    
    
    
     override func delete(_ object: NSManagedObject)  {
        
    return cuckoo_manager.call("delete(_: NSManagedObject)",
            parameters: (object),
            escapingParameters: (object),
            superclassCall:
                
                super.delete(object)
                ,
            defaultCall: __defaultImplStub!.delete(object))
        
    }
    
    
    
     override func save() throws {
        
    return try cuckoo_manager.callThrows("save() throws",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.save()
                ,
            defaultCall: __defaultImplStub!.save())
        
    }
    
    
    
     override func obtainPermanentIDs(for objects: [NSManagedObject]) throws {
        
    return try cuckoo_manager.callThrows("obtainPermanentIDs(for: [NSManagedObject]) throws",
            parameters: (objects),
            escapingParameters: (objects),
            superclassCall:
                
                super.obtainPermanentIDs(for: objects)
                ,
            defaultCall: __defaultImplStub!.obtainPermanentIDs(for: objects))
        
    }
    

	 struct __StubbingProxy_ManagedObjectContext: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var persistentStoreCoordinator: Cuckoo.ClassToBeStubbedOptionalProperty<MockManagedObjectContext, NSPersistentStoreCoordinator> {
	        return .init(manager: cuckoo_manager, name: "persistentStoreCoordinator")
	    }
	    
	    
	    func fetch<M1: Cuckoo.Matchable>(_ request: M1) -> Cuckoo.ClassStubThrowingFunction<(NSFetchRequest<NSFetchRequestResult>), [Any]> where M1.MatchedType == NSFetchRequest<NSFetchRequestResult> {
	        let matchers: [Cuckoo.ParameterMatcher<(NSFetchRequest<NSFetchRequestResult>)>] = [wrap(matchable: request) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "fetch(_: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]", parameterMatchers: matchers))
	    }
	    
	    func existingObject<M1: Cuckoo.Matchable>(with objectID: M1) -> Cuckoo.ClassStubThrowingFunction<(NSManagedObjectID), NSManagedObject> where M1.MatchedType == NSManagedObjectID {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObjectID)>] = [wrap(matchable: objectID) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "existingObject(with: NSManagedObjectID) throws -> NSManagedObject", parameterMatchers: matchers))
	    }
	    
	    func insert<M1: Cuckoo.Matchable>(_ object: M1) -> Cuckoo.ClassStubNoReturnFunction<(NSManagedObject)> where M1.MatchedType == NSManagedObject {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObject)>] = [wrap(matchable: object) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "insert(_: NSManagedObject)", parameterMatchers: matchers))
	    }
	    
	    func delete<M1: Cuckoo.Matchable>(_ object: M1) -> Cuckoo.ClassStubNoReturnFunction<(NSManagedObject)> where M1.MatchedType == NSManagedObject {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObject)>] = [wrap(matchable: object) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "delete(_: NSManagedObject)", parameterMatchers: matchers))
	    }
	    
	    func save() -> Cuckoo.ClassStubNoReturnThrowingFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "save() throws", parameterMatchers: matchers))
	    }
	    
	    func obtainPermanentIDs<M1: Cuckoo.Matchable>(for objects: M1) -> Cuckoo.ClassStubNoReturnThrowingFunction<([NSManagedObject])> where M1.MatchedType == [NSManagedObject] {
	        let matchers: [Cuckoo.ParameterMatcher<([NSManagedObject])>] = [wrap(matchable: objects) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectContext.self, method: "obtainPermanentIDs(for: [NSManagedObject]) throws", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ManagedObjectContext: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var persistentStoreCoordinator: Cuckoo.VerifyOptionalProperty<NSPersistentStoreCoordinator> {
	        return .init(manager: cuckoo_manager, name: "persistentStoreCoordinator", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func fetch<M1: Cuckoo.Matchable>(_ request: M1) -> Cuckoo.__DoNotUse<(NSFetchRequest<NSFetchRequestResult>), [Any]> where M1.MatchedType == NSFetchRequest<NSFetchRequestResult> {
	        let matchers: [Cuckoo.ParameterMatcher<(NSFetchRequest<NSFetchRequestResult>)>] = [wrap(matchable: request) { $0 }]
	        return cuckoo_manager.verify("fetch(_: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func existingObject<M1: Cuckoo.Matchable>(with objectID: M1) -> Cuckoo.__DoNotUse<(NSManagedObjectID), NSManagedObject> where M1.MatchedType == NSManagedObjectID {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObjectID)>] = [wrap(matchable: objectID) { $0 }]
	        return cuckoo_manager.verify("existingObject(with: NSManagedObjectID) throws -> NSManagedObject", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func insert<M1: Cuckoo.Matchable>(_ object: M1) -> Cuckoo.__DoNotUse<(NSManagedObject), Void> where M1.MatchedType == NSManagedObject {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObject)>] = [wrap(matchable: object) { $0 }]
	        return cuckoo_manager.verify("insert(_: NSManagedObject)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func delete<M1: Cuckoo.Matchable>(_ object: M1) -> Cuckoo.__DoNotUse<(NSManagedObject), Void> where M1.MatchedType == NSManagedObject {
	        let matchers: [Cuckoo.ParameterMatcher<(NSManagedObject)>] = [wrap(matchable: object) { $0 }]
	        return cuckoo_manager.verify("delete(_: NSManagedObject)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func save() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("save() throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func obtainPermanentIDs<M1: Cuckoo.Matchable>(for objects: M1) -> Cuckoo.__DoNotUse<([NSManagedObject]), Void> where M1.MatchedType == [NSManagedObject] {
	        let matchers: [Cuckoo.ParameterMatcher<([NSManagedObject])>] = [wrap(matchable: objects) { $0 }]
	        return cuckoo_manager.verify("obtainPermanentIDs(for: [NSManagedObject]) throws", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ManagedObjectContextStub: ManagedObjectContext {
    
    
     override var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSPersistentStoreCoordinator?).self)
        }
        
        set { }
        
    }
    

    

    
     override func fetch(_ request: NSFetchRequest<NSFetchRequestResult>) throws -> [Any]  {
        return DefaultValueRegistry.defaultValue(for: ([Any]).self)
    }
    
     override func existingObject(with objectID: NSManagedObjectID) throws -> NSManagedObject  {
        return DefaultValueRegistry.defaultValue(for: (NSManagedObject).self)
    }
    
     override func insert(_ object: NSManagedObject)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func delete(_ object: NSManagedObject)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func save() throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func obtainPermanentIDs(for objects: [NSManagedObject]) throws  {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockManagedObjectID: ManagedObjectID, Cuckoo.ClassMock {
    
     typealias MocksType = ManagedObjectID
    
     typealias Stubbing = __StubbingProxy_ManagedObjectID
     typealias Verification = __VerificationProxy_ManagedObjectID

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ManagedObjectID?

     func enableDefaultImplementation(_ stub: ManagedObjectID) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func uriRepresentation() -> URL {
        
    return cuckoo_manager.call("uriRepresentation() -> URL",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                super.uriRepresentation()
                ,
            defaultCall: __defaultImplStub!.uriRepresentation())
        
    }
    

	 struct __StubbingProxy_ManagedObjectID: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func uriRepresentation() -> Cuckoo.ClassStubFunction<(), URL> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockManagedObjectID.self, method: "uriRepresentation() -> URL", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ManagedObjectID: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func uriRepresentation() -> Cuckoo.__DoNotUse<(), URL> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("uriRepresentation() -> URL", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ManagedObjectIDStub: ManagedObjectID {
    

    

    
     override func uriRepresentation() -> URL  {
        return DefaultValueRegistry.defaultValue(for: (URL).self)
    }
    
}



 class MockPersistentStoreCoordinator: PersistentStoreCoordinator, Cuckoo.ClassMock {
    
     typealias MocksType = PersistentStoreCoordinator
    
     typealias Stubbing = __StubbingProxy_PersistentStoreCoordinator
     typealias Verification = __VerificationProxy_PersistentStoreCoordinator

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: PersistentStoreCoordinator?

     func enableDefaultImplementation(_ stub: PersistentStoreCoordinator) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var managedObjectModel: NSManagedObjectModel {
        get {
            return cuckoo_manager.getter("managedObjectModel",
                superclassCall:
                    
                    super.managedObjectModel
                    ,
                defaultCall: __defaultImplStub!.managedObjectModel)
        }
        
    }
    

    

    
    
    
     override func managedObjectID(forURIRepresentation url: URL) -> NSManagedObjectID? {
        
    return cuckoo_manager.call("managedObjectID(forURIRepresentation: URL) -> NSManagedObjectID?",
            parameters: (url),
            escapingParameters: (url),
            superclassCall:
                
                super.managedObjectID(forURIRepresentation: url)
                ,
            defaultCall: __defaultImplStub!.managedObjectID(forURIRepresentation: url))
        
    }
    

	 struct __StubbingProxy_PersistentStoreCoordinator: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var managedObjectModel: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockPersistentStoreCoordinator, NSManagedObjectModel> {
	        return .init(manager: cuckoo_manager, name: "managedObjectModel")
	    }
	    
	    
	    func managedObjectID<M1: Cuckoo.Matchable>(forURIRepresentation url: M1) -> Cuckoo.ClassStubFunction<(URL), NSManagedObjectID?> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: url) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPersistentStoreCoordinator.self, method: "managedObjectID(forURIRepresentation: URL) -> NSManagedObjectID?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_PersistentStoreCoordinator: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var managedObjectModel: Cuckoo.VerifyReadOnlyProperty<NSManagedObjectModel> {
	        return .init(manager: cuckoo_manager, name: "managedObjectModel", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func managedObjectID<M1: Cuckoo.Matchable>(forURIRepresentation url: M1) -> Cuckoo.__DoNotUse<(URL), NSManagedObjectID?> where M1.MatchedType == URL {
	        let matchers: [Cuckoo.ParameterMatcher<(URL)>] = [wrap(matchable: url) { $0 }]
	        return cuckoo_manager.verify("managedObjectID(forURIRepresentation: URL) -> NSManagedObjectID?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class PersistentStoreCoordinatorStub: PersistentStoreCoordinator {
    
    
     override var managedObjectModel: NSManagedObjectModel {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSManagedObjectModel).self)
        }
        
    }
    

    

    
     override func managedObjectID(forURIRepresentation url: URL) -> NSManagedObjectID?  {
        return DefaultValueRegistry.defaultValue(for: (NSManagedObjectID?).self)
    }
    
}



 class MockManagedObjectModel: ManagedObjectModel, Cuckoo.ClassMock {
    
     typealias MocksType = ManagedObjectModel
    
     typealias Stubbing = __StubbingProxy_ManagedObjectModel
     typealias Verification = __VerificationProxy_ManagedObjectModel

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: ManagedObjectModel?

     func enableDefaultImplementation(_ stub: ManagedObjectModel) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var entitiesByName: [String : NSEntityDescription] {
        get {
            return cuckoo_manager.getter("entitiesByName",
                superclassCall:
                    
                    super.entitiesByName
                    ,
                defaultCall: __defaultImplStub!.entitiesByName)
        }
        
    }
    

    

    

	 struct __StubbingProxy_ManagedObjectModel: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var entitiesByName: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockManagedObjectModel, [String : NSEntityDescription]> {
	        return .init(manager: cuckoo_manager, name: "entitiesByName")
	    }
	    
	    
	}

	 struct __VerificationProxy_ManagedObjectModel: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var entitiesByName: Cuckoo.VerifyReadOnlyProperty<[String : NSEntityDescription]> {
	        return .init(manager: cuckoo_manager, name: "entitiesByName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class ManagedObjectModelStub: ManagedObjectModel {
    
    
     override var entitiesByName: [String : NSEntityDescription] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String : NSEntityDescription]).self)
        }
        
    }
    

    

    
}



 class MockMConsumptionEntity: MConsumptionEntity, Cuckoo.ClassMock {
    
     typealias MocksType = MConsumptionEntity
    
     typealias Stubbing = __StubbingProxy_MConsumptionEntity
     typealias Verification = __VerificationProxy_MConsumptionEntity

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MConsumptionEntity?

     func enableDefaultImplementation(_ stub: MConsumptionEntity) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var objectID: NSManagedObjectID {
        get {
            return cuckoo_manager.getter("objectID",
                superclassCall:
                    
                    super.objectID
                    ,
                defaultCall: __defaultImplStub!.objectID)
        }
        
    }
    
    
    
     override var session: SessionEntity? {
        get {
            return cuckoo_manager.getter("session",
                superclassCall:
                    
                    super.session
                    ,
                defaultCall: __defaultImplStub!.session)
        }
        
        set {
            cuckoo_manager.setter("session",
                value: newValue,
                superclassCall:
                    
                    super.session = newValue
                    ,
                defaultCall: __defaultImplStub!.session = newValue)
        }
        
    }
    
    
    
     override var drink: String? {
        get {
            return cuckoo_manager.getter("drink",
                superclassCall:
                    
                    super.drink
                    ,
                defaultCall: __defaultImplStub!.drink)
        }
        
        set {
            cuckoo_manager.setter("drink",
                value: newValue,
                superclassCall:
                    
                    super.drink = newValue
                    ,
                defaultCall: __defaultImplStub!.drink = newValue)
        }
        
    }
    
    
    
     override var alcohol: Double {
        get {
            return cuckoo_manager.getter("alcohol",
                superclassCall:
                    
                    super.alcohol
                    ,
                defaultCall: __defaultImplStub!.alcohol)
        }
        
        set {
            cuckoo_manager.setter("alcohol",
                value: newValue,
                superclassCall:
                    
                    super.alcohol = newValue
                    ,
                defaultCall: __defaultImplStub!.alcohol = newValue)
        }
        
    }
    
    
    
     override var date: Date? {
        get {
            return cuckoo_manager.getter("date",
                superclassCall:
                    
                    super.date
                    ,
                defaultCall: __defaultImplStub!.date)
        }
        
        set {
            cuckoo_manager.setter("date",
                value: newValue,
                superclassCall:
                    
                    super.date = newValue
                    ,
                defaultCall: __defaultImplStub!.date = newValue)
        }
        
    }
    
    
    
     override var quantity: Double {
        get {
            return cuckoo_manager.getter("quantity",
                superclassCall:
                    
                    super.quantity
                    ,
                defaultCall: __defaultImplStub!.quantity)
        }
        
        set {
            cuckoo_manager.setter("quantity",
                value: newValue,
                superclassCall:
                    
                    super.quantity = newValue
                    ,
                defaultCall: __defaultImplStub!.quantity = newValue)
        }
        
    }
    
    
    
     override var unit: Int16 {
        get {
            return cuckoo_manager.getter("unit",
                superclassCall:
                    
                    super.unit
                    ,
                defaultCall: __defaultImplStub!.unit)
        }
        
        set {
            cuckoo_manager.setter("unit",
                value: newValue,
                superclassCall:
                    
                    super.unit = newValue
                    ,
                defaultCall: __defaultImplStub!.unit = newValue)
        }
        
    }
    

    

    

	 struct __StubbingProxy_MConsumptionEntity: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var objectID: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockMConsumptionEntity, NSManagedObjectID> {
	        return .init(manager: cuckoo_manager, name: "objectID")
	    }
	    
	    
	    var session: Cuckoo.ClassToBeStubbedOptionalProperty<MockMConsumptionEntity, SessionEntity> {
	        return .init(manager: cuckoo_manager, name: "session")
	    }
	    
	    
	    var drink: Cuckoo.ClassToBeStubbedOptionalProperty<MockMConsumptionEntity, String> {
	        return .init(manager: cuckoo_manager, name: "drink")
	    }
	    
	    
	    var alcohol: Cuckoo.ClassToBeStubbedProperty<MockMConsumptionEntity, Double> {
	        return .init(manager: cuckoo_manager, name: "alcohol")
	    }
	    
	    
	    var date: Cuckoo.ClassToBeStubbedOptionalProperty<MockMConsumptionEntity, Date> {
	        return .init(manager: cuckoo_manager, name: "date")
	    }
	    
	    
	    var quantity: Cuckoo.ClassToBeStubbedProperty<MockMConsumptionEntity, Double> {
	        return .init(manager: cuckoo_manager, name: "quantity")
	    }
	    
	    
	    var unit: Cuckoo.ClassToBeStubbedProperty<MockMConsumptionEntity, Int16> {
	        return .init(manager: cuckoo_manager, name: "unit")
	    }
	    
	    
	}

	 struct __VerificationProxy_MConsumptionEntity: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var objectID: Cuckoo.VerifyReadOnlyProperty<NSManagedObjectID> {
	        return .init(manager: cuckoo_manager, name: "objectID", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var session: Cuckoo.VerifyOptionalProperty<SessionEntity> {
	        return .init(manager: cuckoo_manager, name: "session", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var drink: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "drink", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var alcohol: Cuckoo.VerifyProperty<Double> {
	        return .init(manager: cuckoo_manager, name: "alcohol", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var date: Cuckoo.VerifyOptionalProperty<Date> {
	        return .init(manager: cuckoo_manager, name: "date", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var quantity: Cuckoo.VerifyProperty<Double> {
	        return .init(manager: cuckoo_manager, name: "quantity", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var unit: Cuckoo.VerifyProperty<Int16> {
	        return .init(manager: cuckoo_manager, name: "unit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class MConsumptionEntityStub: MConsumptionEntity {
    
    
     override var objectID: NSManagedObjectID {
        get {
            return DefaultValueRegistry.defaultValue(for: (NSManagedObjectID).self)
        }
        
    }
    
    
     override var session: SessionEntity? {
        get {
            return DefaultValueRegistry.defaultValue(for: (SessionEntity?).self)
        }
        
        set { }
        
    }
    
    
     override var drink: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     override var alcohol: Double {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double).self)
        }
        
        set { }
        
    }
    
    
     override var date: Date? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Date?).self)
        }
        
        set { }
        
    }
    
    
     override var quantity: Double {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double).self)
        }
        
        set { }
        
    }
    
    
     override var unit: Int16 {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int16).self)
        }
        
        set { }
        
    }
    

    

    
}



 class MockMSessionEntity: MSessionEntity, Cuckoo.ClassMock {
    
     typealias MocksType = MSessionEntity
    
     typealias Stubbing = __StubbingProxy_MSessionEntity
     typealias Verification = __VerificationProxy_MSessionEntity

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MSessionEntity?

     func enableDefaultImplementation(_ stub: MSessionEntity) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    

	 struct __StubbingProxy_MSessionEntity: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	}

	 struct __VerificationProxy_MSessionEntity: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	}
}

 class MSessionEntityStub: MSessionEntity {
    

    

    
}


// MARK: - Mocks generated from file: DeliriumOverTests/TestUtils/Mock/Firebase.swift at 2020-10-04 20:36:32 +0000

//
//  Firebase.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 10. 02..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Cuckoo
@testable import DeliriumOver

import FirebaseAuth
import FirebaseDatabase
import Foundation


 class MockFirebaseDatabaseReference: FirebaseDatabaseReference, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseDatabaseReference
    
     typealias Stubbing = __StubbingProxy_FirebaseDatabaseReference
     typealias Verification = __VerificationProxy_FirebaseDatabaseReference

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseDatabaseReference?

     func enableDefaultImplementation(_ stub: FirebaseDatabaseReference) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     override func child(_ pathString: String) -> DatabaseReference {
        
    return cuckoo_manager.call("child(_: String) -> DatabaseReference",
            parameters: (pathString),
            escapingParameters: (pathString),
            superclassCall:
                
                super.child(pathString)
                ,
            defaultCall: __defaultImplStub!.child(pathString))
        
    }
    
    
    
     override func keepSynced(_ synced: Bool)  {
        
    return cuckoo_manager.call("keepSynced(_: Bool)",
            parameters: (synced),
            escapingParameters: (synced),
            superclassCall:
                
                super.keepSynced(synced)
                ,
            defaultCall: __defaultImplStub!.keepSynced(synced))
        
    }
    
    
    
     override func observe(_ eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) -> UInt {
        
    return cuckoo_manager.call("observe(_: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?) -> UInt",
            parameters: (eventType, block, cancelBlock),
            escapingParameters: (eventType, block, cancelBlock),
            superclassCall:
                
                super.observe(eventType, with: block, withCancel: cancelBlock)
                ,
            defaultCall: __defaultImplStub!.observe(eventType, with: block, withCancel: cancelBlock))
        
    }
    
    
    
     override func observeSingleEvent(of eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)  {
        
    return cuckoo_manager.call("observeSingleEvent(of: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)",
            parameters: (eventType, block, cancelBlock),
            escapingParameters: (eventType, block, cancelBlock),
            superclassCall:
                
                super.observeSingleEvent(of: eventType, with: block, withCancel: cancelBlock)
                ,
            defaultCall: __defaultImplStub!.observeSingleEvent(of: eventType, with: block, withCancel: cancelBlock))
        
    }
    
    
    
     override func setValue(_ value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void)  {
        
    return cuckoo_manager.call("setValue(_: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)",
            parameters: (value, block),
            escapingParameters: (value, block),
            superclassCall:
                
                super.setValue(value, withCompletionBlock: block)
                ,
            defaultCall: __defaultImplStub!.setValue(value, withCompletionBlock: block))
        
    }
    

	 struct __StubbingProxy_FirebaseDatabaseReference: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func child<M1: Cuckoo.Matchable>(_ pathString: M1) -> Cuckoo.ClassStubFunction<(String), DatabaseReference> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: pathString) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseDatabaseReference.self, method: "child(_: String) -> DatabaseReference", parameterMatchers: matchers))
	    }
	    
	    func keepSynced<M1: Cuckoo.Matchable>(_ synced: M1) -> Cuckoo.ClassStubNoReturnFunction<(Bool)> where M1.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: synced) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseDatabaseReference.self, method: "keepSynced(_: Bool)", parameterMatchers: matchers))
	    }
	    
	    func observe<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ eventType: M1, with block: M2, withCancel cancelBlock: M3) -> Cuckoo.ClassStubFunction<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?), UInt> where M1.MatchedType == DataEventType, M2.MatchedType == (DataSnapshot) -> Void, M3.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: eventType) { $0.0 }, wrap(matchable: block) { $0.1 }, wrap(matchable: cancelBlock) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseDatabaseReference.self, method: "observe(_: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?) -> UInt", parameterMatchers: matchers))
	    }
	    
	    func observeSingleEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(of eventType: M1, with block: M2, withCancel cancelBlock: M3) -> Cuckoo.ClassStubNoReturnFunction<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)> where M1.MatchedType == DataEventType, M2.MatchedType == (DataSnapshot) -> Void, M3.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: eventType) { $0.0 }, wrap(matchable: block) { $0.1 }, wrap(matchable: cancelBlock) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseDatabaseReference.self, method: "observeSingleEvent(of: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", parameterMatchers: matchers))
	    }
	    
	    func setValue<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ value: M1, withCompletionBlock block: M2) -> Cuckoo.ClassStubNoReturnFunction<(Any?, (Error?, DatabaseReference) -> Void)> where M1.OptionalMatchedType == Any, M2.MatchedType == (Error?, DatabaseReference) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Any?, (Error?, DatabaseReference) -> Void)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: block) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseDatabaseReference.self, method: "setValue(_: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseDatabaseReference: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func child<M1: Cuckoo.Matchable>(_ pathString: M1) -> Cuckoo.__DoNotUse<(String), DatabaseReference> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: pathString) { $0 }]
	        return cuckoo_manager.verify("child(_: String) -> DatabaseReference", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func keepSynced<M1: Cuckoo.Matchable>(_ synced: M1) -> Cuckoo.__DoNotUse<(Bool), Void> where M1.MatchedType == Bool {
	        let matchers: [Cuckoo.ParameterMatcher<(Bool)>] = [wrap(matchable: synced) { $0 }]
	        return cuckoo_manager.verify("keepSynced(_: Bool)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func observe<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(_ eventType: M1, with block: M2, withCancel cancelBlock: M3) -> Cuckoo.__DoNotUse<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?), UInt> where M1.MatchedType == DataEventType, M2.MatchedType == (DataSnapshot) -> Void, M3.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: eventType) { $0.0 }, wrap(matchable: block) { $0.1 }, wrap(matchable: cancelBlock) { $0.2 }]
	        return cuckoo_manager.verify("observe(_: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?) -> UInt", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func observeSingleEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.OptionalMatchable>(of eventType: M1, with block: M2, withCancel cancelBlock: M3) -> Cuckoo.__DoNotUse<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?), Void> where M1.MatchedType == DataEventType, M2.MatchedType == (DataSnapshot) -> Void, M3.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: eventType) { $0.0 }, wrap(matchable: block) { $0.1 }, wrap(matchable: cancelBlock) { $0.2 }]
	        return cuckoo_manager.verify("observeSingleEvent(of: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setValue<M1: Cuckoo.OptionalMatchable, M2: Cuckoo.Matchable>(_ value: M1, withCompletionBlock block: M2) -> Cuckoo.__DoNotUse<(Any?, (Error?, DatabaseReference) -> Void), Void> where M1.OptionalMatchedType == Any, M2.MatchedType == (Error?, DatabaseReference) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(Any?, (Error?, DatabaseReference) -> Void)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: block) { $0.1 }]
	        return cuckoo_manager.verify("setValue(_: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseDatabaseReferenceStub: FirebaseDatabaseReference {
    

    

    
     override func child(_ pathString: String) -> DatabaseReference  {
        return DefaultValueRegistry.defaultValue(for: (DatabaseReference).self)
    }
    
     override func keepSynced(_ synced: Bool)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func observe(_ eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?) -> UInt  {
        return DefaultValueRegistry.defaultValue(for: (UInt).self)
    }
    
     override func observeSingleEvent(of eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     override func setValue(_ value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockMockDataSnapshot: MockDataSnapshot, Cuckoo.ClassMock {
    
     typealias MocksType = MockDataSnapshot
    
     typealias Stubbing = __StubbingProxy_MockDataSnapshot
     typealias Verification = __VerificationProxy_MockDataSnapshot

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: MockDataSnapshot?

     func enableDefaultImplementation(_ stub: MockDataSnapshot) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var value: Any? {
        get {
            return cuckoo_manager.getter("value",
                superclassCall:
                    
                    super.value
                    ,
                defaultCall: __defaultImplStub!.value)
        }
        
    }
    

    

    

	 struct __StubbingProxy_MockDataSnapshot: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var value: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockMockDataSnapshot, Any?> {
	        return .init(manager: cuckoo_manager, name: "value")
	    }
	    
	    
	}

	 struct __VerificationProxy_MockDataSnapshot: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var value: Cuckoo.VerifyReadOnlyProperty<Any?> {
	        return .init(manager: cuckoo_manager, name: "value", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class MockDataSnapshotStub: MockDataSnapshot {
    
    
     override var value: Any? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Any?).self)
        }
        
    }
    

    

    
}



 class MockFirebaseAuth: FirebaseAuth, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseAuth
    
     typealias Stubbing = __StubbingProxy_FirebaseAuth
     typealias Verification = __VerificationProxy_FirebaseAuth

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseAuth?

     func enableDefaultImplementation(_ stub: FirebaseAuth) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var currentUser: User? {
        get {
            return cuckoo_manager.getter("currentUser",
                superclassCall:
                    
                    super.currentUser
                    ,
                defaultCall: __defaultImplStub!.currentUser)
        }
        
    }
    

    

    
    
    
     override func signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)  {
        
    return cuckoo_manager.call("signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)",
            parameters: (completion),
            escapingParameters: (completion),
            superclassCall:
                
                super.signInAnonymously(completion: completion)
                ,
            defaultCall: __defaultImplStub!.signInAnonymously(completion: completion))
        
    }
    

	 struct __StubbingProxy_FirebaseAuth: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var currentUser: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockFirebaseAuth, User?> {
	        return .init(manager: cuckoo_manager, name: "currentUser")
	    }
	    
	    
	    func signInAnonymously<M1: Cuckoo.OptionalMatchable>(completion: M1) -> Cuckoo.ClassStubNoReturnFunction<(((AuthDataResult?, Error?) -> Void)?)> where M1.OptionalMatchedType == ((AuthDataResult?, Error?) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(((AuthDataResult?, Error?) -> Void)?)>] = [wrap(matchable: completion) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockFirebaseAuth.self, method: "signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_FirebaseAuth: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var currentUser: Cuckoo.VerifyReadOnlyProperty<User?> {
	        return .init(manager: cuckoo_manager, name: "currentUser", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func signInAnonymously<M1: Cuckoo.OptionalMatchable>(completion: M1) -> Cuckoo.__DoNotUse<(((AuthDataResult?, Error?) -> Void)?), Void> where M1.OptionalMatchedType == ((AuthDataResult?, Error?) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(((AuthDataResult?, Error?) -> Void)?)>] = [wrap(matchable: completion) { $0 }]
	        return cuckoo_manager.verify("signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class FirebaseAuthStub: FirebaseAuth {
    
    
     override var currentUser: User? {
        get {
            return DefaultValueRegistry.defaultValue(for: (User?).self)
        }
        
    }
    

    

    
     override func signInAnonymously(completion: ((AuthDataResult?, Error?) -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



 class MockFirebaseUser: FirebaseUser, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseUser
    
     typealias Stubbing = __StubbingProxy_FirebaseUser
     typealias Verification = __VerificationProxy_FirebaseUser

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseUser?

     func enableDefaultImplementation(_ stub: FirebaseUser) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var uid: String {
        get {
            return cuckoo_manager.getter("uid",
                superclassCall:
                    
                    super.uid
                    ,
                defaultCall: __defaultImplStub!.uid)
        }
        
    }
    

    

    

	 struct __StubbingProxy_FirebaseUser: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var uid: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockFirebaseUser, String> {
	        return .init(manager: cuckoo_manager, name: "uid")
	    }
	    
	    
	}

	 struct __VerificationProxy_FirebaseUser: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var uid: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "uid", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class FirebaseUserStub: FirebaseUser {
    
    
     override var uid: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
}



 class MockFirebaseAuthDataResult: FirebaseAuthDataResult, Cuckoo.ClassMock {
    
     typealias MocksType = FirebaseAuthDataResult
    
     typealias Stubbing = __StubbingProxy_FirebaseAuthDataResult
     typealias Verification = __VerificationProxy_FirebaseAuthDataResult

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: true)

    
    private var __defaultImplStub: FirebaseAuthDataResult?

     func enableDefaultImplementation(_ stub: FirebaseAuthDataResult) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     override var user: User {
        get {
            return cuckoo_manager.getter("user",
                superclassCall:
                    
                    super.user
                    ,
                defaultCall: __defaultImplStub!.user)
        }
        
    }
    

    

    

	 struct __StubbingProxy_FirebaseAuthDataResult: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var user: Cuckoo.ClassToBeStubbedReadOnlyProperty<MockFirebaseAuthDataResult, User> {
	        return .init(manager: cuckoo_manager, name: "user")
	    }
	    
	    
	}

	 struct __VerificationProxy_FirebaseAuthDataResult: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var user: Cuckoo.VerifyReadOnlyProperty<User> {
	        return .init(manager: cuckoo_manager, name: "user", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class FirebaseAuthDataResultStub: FirebaseAuthDataResult {
    
    
     override var user: User {
        get {
            return DefaultValueRegistry.defaultValue(for: (User).self)
        }
        
    }
    

    

    
}

