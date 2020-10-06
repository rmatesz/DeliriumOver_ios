//
//  ConsumptionDAOTests.swift
//  DeliriumOverTests
//
//  Created by mate.redecsi on 2020. 09. 30..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import CoreData
import Cuckoo
import Foundation
import XCTest
import RxSwift
@testable import DeliriumOver

class ConsumptionDAOTests : XCTestCase {
    private let sessionId = "x-coredata://F1697911-CD8A-4D63-B40F-AB0CA020C873/Session/p1"
    private lazy var sessionIdURL = URL(string: sessionId)!
    private let sessionObjectId = MockManagedObjectID()
    private let sessionEntity = MockMSessionEntity()
    private let now = Date()
    private lazy var consumption1 = Consumption("x-coredata://F1697911-CD8A-4D63-B40F-AB0CA020C873/Consumption/p1", drink: "Beer", quantity: 5, unit: .deciliter, alcohol: 5, date: now)
    private lazy var consumption2 = Consumption("x-coredata://F1697911-CD8A-4D63-B40F-AB0CA020C873/Consumption/p2", drink: "Palinka", quantity: 5, unit: .centiliter, alcohol: 55, date: now)
    private let context = MockManagedObjectContext()
    private let consumptionEntity1 = MockMConsumptionEntity()
    private let consumptionEntity2 = MockMConsumptionEntity()
    private let consumptionId1 = MockManagedObjectID()
    private let consumptionId2 = MockManagedObjectID()
    private let persistentStoreCoordinator = MockPersistentStoreCoordinator()
    private let managedObjectModel = MockManagedObjectModel()
    private let coreDataAdapter = MockCoreDataAdapter()
    private let id1Str = "x-coredata://F1697911-CD8A-4D63-B40F-AB0CA020C873/Consumption/p1"
    private let id2Str = "x-coredata://F1697911-CD8A-4D63-B40F-AB0CA020C873/Consumption/p2"
    private lazy var id1 = URL(string: id1Str)!
    private lazy var id2 = URL(string: id2Str)!
    private lazy var underTest = ConsumptionDAOImpl(context: context, coreDataAdapter: coreDataAdapter)

    override func setUp() {
        stub(context) { mock in
            mock.persistentStoreCoordinator.get.thenReturn(persistentStoreCoordinator)
            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenReturn(consumptionEntity1)
            mock.existingObject(with: consumptionId2 as NSManagedObjectID).thenReturn(consumptionEntity2)
            mock.existingObject(with: sessionObjectId as NSManagedObjectID).thenReturn(sessionEntity)
        }

        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectModel.get.thenReturn(managedObjectModel)
        }

        stub(managedObjectModel) { mock in
            var desc = NSEntityDescription()
            desc.name = "ConsumptionEntity"
            mock.entitiesByName.get.thenReturn(["ConsumptionEntity": desc])
        }

        stub(consumptionEntity1) { mock in
            mock.objectID.get.thenReturn(consumptionId1)
            mock.drink.get.thenReturn(consumption1.drink)
            mock.alcohol.get.thenReturn(consumption1.alcohol)
            mock.quantity.get.thenReturn(consumption1.quantity)
            mock.unit.get.thenReturn(Int16(consumption1.unit.rawValue))
            mock.date.get.thenReturn(consumption1.date)

            mock.session.set(any()).thenDoNothing()
            mock.drink.set(any()).thenDoNothing()
            mock.alcohol.set(any()).thenDoNothing()
            mock.quantity.set(any()).thenDoNothing()
            mock.unit.set(any()).thenDoNothing()
            mock.date.set(any()).thenDoNothing()
        }

        stub(sessionObjectId) { mock in
            mock.uriRepresentation().thenReturn(sessionIdURL)
        }

        stub(consumptionId1) { mock in
            mock.uriRepresentation().thenReturn(id1)
        }

        stub(consumptionId2) { mock in
            mock.uriRepresentation().thenReturn(id2)
        }

        stub(consumptionEntity2) { mock in
            mock.objectID.get.thenReturn(consumptionId2)
            mock.drink.get.thenReturn(consumption2.drink)
            mock.alcohol.get.thenReturn(consumption2.alcohol)
            mock.quantity.get.thenReturn(consumption2.quantity)
            mock.unit.get.thenReturn(Int16(consumption2.unit.rawValue))
            mock.date.get.thenReturn(consumption2.date)

            mock.session.set(any()).thenDoNothing()
            mock.drink.set(any()).thenDoNothing()
            mock.alcohol.set(any()).thenDoNothing()
            mock.quantity.set(any()).thenDoNothing()
            mock.unit.set(any()).thenDoNothing()
            mock.date.set(any()).thenDoNothing()
        }
    }

    func testGetAllWhenSuccess() throws {
        let argumentCaptor = ArgumentCaptor<NSFetchRequest<NSFetchRequestResult>>()
        stub(context) { mock in
            when(mock.fetch(argumentCaptor.capture())).thenReturn([consumptionEntity1, consumptionEntity2])
        }

        let result = try underTest.getAll(sessionId: sessionId).toBlocking().first()!
        XCTAssertEqual([consumption1, consumption2], result)
        XCTAssertEqual(argumentCaptor.value?.entityName, "ConsumptionEntity")
        XCTAssertEqual(argumentCaptor.value?.predicate, NSPredicate(format: "sessionId == %@", sessionId))
    }

    func testGetAllWhenFetchThrowsError() throws {
        let error = "FETCH ISSUE"
        stub(context) { mock in
            when(mock.fetch(any())).thenThrow(error)
        }

        do {
            _ = try underTest.getAll(sessionId: sessionId).toBlocking().first()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testGet() throws {
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
        }
        
        let result = try underTest.get(id1Str).toBlocking().first()
        XCTAssertEqual(consumption1, result)
    }

    func testGetWhenInvalidObjectID() throws {
        do {
            _ = try underTest.get("id1<Str>").toBlocking().first()
            XCTFail()
        } catch {
            XCTAssertEqual(DatabaseError(message: "Invalid objectID: id1<Str>"), error as! DatabaseError)
        }
    }

    func testGetWhenObjectIDNotFound() throws {
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(nil)
        }

        let result = try underTest.get(id1Str).toBlocking().first()
        XCTAssertNil(result)
    }

    func testGetWhenGetExistingObjectFailure() throws {
        let error = "Database IO error"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
        }
        stub(context) { mock in
            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenThrow(error)
        }

        do {
            _ = try underTest.get(id1Str).toBlocking().first()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testGetWhenGetExistingObjectReturnsInvalidEntity() throws {
        let invalidEntity = SessionEntity()
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
        }
        stub(context) { mock in
            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenReturn(invalidEntity)
        }

        do {
            _ = try underTest.get(id1Str).toBlocking().first()
            XCTFail()
        } catch {
            XCTAssertEqual(DatabaseError(message: "The id(\(id1Str) doesn't represent the expected entity \(ConsumptionEntity.Type.self). The returned object is: \(invalidEntity)"), error as! DatabaseError)
        }
    }

    func testDelete() throws {
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
            mock.managedObjectID(forURIRepresentation: id2).thenReturn(consumptionId2)
        }
        stub(context) { mock in
            mock.delete(any()).thenDoNothing()
            mock.save().thenDoNothing()
        }
        _ = try underTest.delete(consumptions: consumption1, consumption2).toBlocking().toArray()

        verify(context).delete(consumptionEntity1 as NSManagedObject)
        verify(context).delete(consumptionEntity2 as NSManagedObject)
        verify(context, times(2)).save()
    }

    func testDeleteWhenInvalidObjectID() throws {
        do {
            _ = try underTest.delete(consumptions: Consumption("id1<Str>")).toBlocking().first()
            XCTFail()
        } catch {
            XCTAssertEqual(DatabaseError(message: "Invalid objectID: id1<Str>"), error as! DatabaseError)
        }
    }

    func testDeleteWhenObjectIDNotFound() throws {
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(nil)
        }

        do{
            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
        } catch {
            XCTAssert(error is DatabaseError)
            XCTAssertEqual(DatabaseError(message: "Can't find consumption in DB."), error as! DatabaseError)
        }
    }

    func testDeleteWhenGetExistingObjectFailure() throws {
        let error = "Database IO error"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
        }
        stub(context) { mock in
            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenThrow(error)
        }

        do {
            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testDeleteWhenGetExistingObjectReturnsInvalidEntity() throws {
        let invalidEntity = SessionEntity()
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
        }
        stub(context) { mock in
            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenReturn(invalidEntity)
        }

        do {
            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
            XCTFail()
        } catch {
            XCTAssertEqual(DatabaseError(message: "The id(\(id1Str) doesn't represent the expected entity \(ConsumptionEntity.Type.self). The returned object is: \(invalidEntity)"), error as! DatabaseError)
        }
    }

    func testDeleteWhenSaveThrowsError() throws {
        let error = "Save error"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
            mock.managedObjectID(forURIRepresentation: id2).thenReturn(consumptionId2)
        }
        stub(context) { mock in
            mock.delete(any()).thenDoNothing()
            mock.save().thenThrow(error)
        }
        do {
            _ = try underTest.delete(consumptions: consumption1).toBlocking().toArray()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testInsert() throws {
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: sessionIdURL).thenReturn(sessionObjectId)
        }
        stub(coreDataAdapter) { mock in
            mock.insertNewObject(forEntityName: "ConsumptionEntity", into: context as NSManagedObjectContext).thenReturn(Single.just(consumptionEntity1))
        }
        stub(context) { mock in
            mock.insert(any()).thenDoNothing()
            mock.obtainPermanentIDs(for: any()).thenDoNothing()
            mock.save().thenDoNothing()
        }
        _ = try underTest.insert(sessionId: sessionId, consumption: consumption1).toBlocking().toArray()

        verify(consumptionEntity1).session.set(sessionEntity)
        verify(consumptionEntity1).alcohol.set(consumption1.alcohol)
        verify(consumptionEntity1).date.set(consumption1.date)
        verify(consumptionEntity1).drink.set(consumption1.drink)
        verify(consumptionEntity1).quantity.set(consumption1.quantity)
        verify(consumptionEntity1).unit.set(Int16(consumption1.unit.rawValue))
        verify(context).obtainPermanentIDs(for: [consumptionEntity1])
        verify(context).save()
    }

    func testInsertWhenNewObjectCreationFails() throws {
        let error = "ERROR"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: sessionIdURL).thenReturn(sessionObjectId)
        }
        stub(coreDataAdapter) { mock in
            mock.insertNewObject(forEntityName: "ConsumptionEntity", into: context as NSManagedObjectContext).thenReturn(Single.error(error))
        }
        stub(context) { mock in
            mock.insert(any()).thenDoNothing()
            mock.obtainPermanentIDs(for: any()).thenDoNothing()
            mock.save().thenDoNothing()
        }
        do {
            _ = try underTest.insert(sessionId: sessionId, consumption: consumption1).toBlocking().toArray()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testInsertWhenObtainPersistentIdFails() throws {
        let error = "ERROR"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: sessionIdURL).thenReturn(sessionObjectId)
        }
        stub(coreDataAdapter) { mock in
            mock.insertNewObject(forEntityName: "ConsumptionEntity", into: context as NSManagedObjectContext).thenReturn(Single.just(consumptionEntity1))
        }
        stub(context) { mock in
            mock.insert(any()).thenDoNothing()
            mock.obtainPermanentIDs(for: any()).thenThrow(error)
            mock.save().thenDoNothing()
        }
        do {
            _ = try underTest.insert(sessionId: sessionId, consumption: consumption1).toBlocking().toArray()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

    func testInsertWhenSaveFails() throws {
        let error = "ERROR"
        stub(persistentStoreCoordinator) { mock in
            mock.managedObjectID(forURIRepresentation: sessionIdURL).thenReturn(sessionObjectId)
        }
        stub(coreDataAdapter) { mock in
            mock.insertNewObject(forEntityName: "ConsumptionEntity", into: context as NSManagedObjectContext).thenReturn(Single.just(consumptionEntity1))
        }
        stub(context) { mock in
            mock.insert(any()).thenDoNothing()
            mock.obtainPermanentIDs(for: any()).thenDoNothing()
            mock.save().thenThrow(error)
        }
        do {
            _ = try underTest.insert(sessionId: sessionId, consumption: consumption1).toBlocking().toArray()
            XCTFail()
        } catch let e {
            XCTAssertEqual(error, e as! String)
        }
    }

//    func testDeleteWhenInvalidObjectID() throws {
//        do {
//            _ = try underTest.delete(consumptions: Consumption("id1<Str>")).toBlocking().first()
//            assertionFailure("Error should be thrown")
//        } catch {
//            XCTAssertEqual(DatabaseError(message: "Invalid objectID: id1<Str>"), error as! DatabaseError)
//        }
//    }
//
//    func testDeleteWhenObjectIDNotFound() throws {
//        stub(persistentStoreCoordinator) { mock in
//            mock.managedObjectID(forURIRepresentation: id1).thenReturn(nil)
//        }
//
//        do{
//            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
//        } catch {
//            XCTAssert(error is DatabaseError)
//            XCTAssertEqual(DatabaseError(message: "Can't find consumption in DB."), error as! DatabaseError)
//        }
//    }
//
//    func testDeleteWhenGetExistingObjectFailure() throws {
//        let error = "Database IO error"
//        stub(persistentStoreCoordinator) { mock in
//            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
//        }
//        stub(context) { mock in
//            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenThrow(error)
//        }
//
//        do {
//            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
//            assertionFailure("Error should be thrown")
//        } catch let e {
//            XCTAssertEqual(error, e as! String)
//        }
//    }
//
//    func testDeleteWhenGetExistingObjectReturnsInvalidEntity() throws {
//        let invalidEntity = SessionEntity()
//        stub(persistentStoreCoordinator) { mock in
//            mock.managedObjectID(forURIRepresentation: id1).thenReturn(consumptionId1)
//        }
//        stub(context) { mock in
//            mock.existingObject(with: consumptionId1 as NSManagedObjectID).thenReturn(invalidEntity)
//        }
//
//        do {
//            _ = try underTest.delete(consumptions: consumption1).toBlocking().first()
//            assertionFailure("Error should be thrown")
//        } catch {
//            XCTAssertEqual(DatabaseError(message: "The id(\(id1Str) doesn't represent the expected entity \(ConsumptionEntity.Type.self). The returned object is: \(invalidEntity)"), error as! DatabaseError)
//        }
//    }

}

extension Date: OptionalMatchable { }
extension SessionEntity: OptionalMatchable { }
extension NSManagedObjectID: Matchable { }
extension URL: Matchable { }
extension NSManagedObjectContext: Matchable { }
extension DatabaseError: Equatable {
    public static func == (lhs: DatabaseError, rhs: DatabaseError) -> Bool {
        return lhs.message == rhs.message
    }
}
extension NSManagedObject: Matchable { }
