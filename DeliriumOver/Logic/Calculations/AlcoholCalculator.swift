//
//  AlcoholCalculator.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

private let kFemaleAverageWeight = 69.0
private let kMaleAverageWeight = 83.0
private let kAlcoholDensity = 0.789 // g/cm3
private let kGenderCoefficientMale = 0.7
private let kGenderCoefficientFemale = 0.6
private let kAlcoholAbsorptionTime: Double = Double(30 * 60)
private let kAlcoholAbsorptionLoss = 0.15
private let kAlcoholEliminationRate = 0.15 // 

public class AlcoholCalculator {
    func calcTimeOfZeroBAC(_ session: Session) -> Date {
        if (session.consumptions.isEmpty) {
            return dateProvider.currentDate
        }
        
        let lastConsumption =
            session.consumptions.sorted(by: { (left, right) -> Bool in left.date < right.date
            })[session.consumptions.count - 1]
        let consumptions = getRelevantConsumptions(
            session: session,
            date: Date(timeIntervalSince1970: lastConsumption.date.timeIntervalSince1970.advanced(by: kAlcoholAbsorptionTime))
        )
        
        let startDate = consumptions[0].date
        let endDate = Date(timeIntervalSince1970: consumptions.last!.date.timeIntervalSince1970.advanced(by: kAlcoholAbsorptionTime))
        let alcohol = absorption(consumptions: consumptions, date: endDate, absorptionLoss: 0.0)
        let alcoholBAC = calcBloodAlcoholConcentration(alcohol: alcohol, gender: session.gender, weight: getWeight(session))
        
        let eliminationRate = min(
            kAlcoholEliminationRate,
            alcoholBAC / (Double(endDate.timeIntervalSince(startDate)) / Double(kOneHourInSeconds))
        )
        
        return Date(timeIntervalSince1970: consumptions[0].date.timeIntervalSince1970.advanced(by: ((alcoholBAC / eliminationRate) * Double(kOneHourInSeconds))))
    }
    
    private func getRelevantConsumptions(session: Session, date: Date) -> [Consumption] {
        let consumptions = session.consumptions.sorted(by: {(left, right) -> Bool in left.date < right.date})
            .filter { (consumption) -> Bool in
                date > consumption.date
            }
        var relevantConsumptions: [Consumption] = []
        for i in (0..<consumptions.count).reversed() {
            relevantConsumptions.insert(consumptions[i], at: 0)
            if (i - 1 >= 0 && calcBloodAlcoholConcentration(
                session: session,
                date: consumptions[i].date
                ) == 0.0 && consumptions[i - 1].date != consumptions[i].date
                ) {
                break
            }
        }
        return relevantConsumptions
    }
    
    func calcBloodAlcoholConcentration(session: Session, date: Date) -> Double {
        let consumptions = getRelevantConsumptions(session: session, date: date)
    
        if (consumptions.isEmpty) {
            return 0.0
        }
        let alcohol = absorption(consumptions: consumptions, date: date, absorptionLoss: 0.0)
    
        let elapsedHours = max(0.0, Double(date.timeIntervalSince(consumptions[0].date)) / Double(kOneHourInSeconds))
    
        return max(
            0.0,
            calcBloodAlcoholConcentration(
                alcohol: alcohol,
                gender: session.gender,
                weight: getWeight(session)
            ) - elapsedHours * kAlcoholEliminationRate
        )
    }
    
    internal func calcAlcoholWeight(
        quantity: Double,
        drinkUnit: DrinkUnit,
        alcohol: Double
    ) -> Double {
        return (quantity * Double(drinkUnit.multiplier())) * alcohol * kAlcoholDensity
    }
    
    /**
     * Widmark-formula
     */
    internal func calcBloodAlcoholConcentration(
        alcohol: Double,
        gender: Sex,
        weight: Double
    ) -> Double {
        return alcohol / (getGenderCoefficient(gender) * weight)
    }
    
    private func getGenderCoefficient(_ gender: Sex) -> Double {
        if (gender == Sex.MALE) {
            return kGenderCoefficientMale
        } else {
            return kGenderCoefficientFemale
        }
    }
    
    // adott időpillanatig összes felszívódott alkohol
    private func absorption(
        consumptions: [Consumption],
        date: Date,
        absorptionLoss: Double = kAlcoholAbsorptionLoss
        ) -> Double {
        return consumptions.filter({ (consumption) -> Bool in
            consumption.date < date
        }).reduce(0, { (result, consumption) -> Double in
            result
                + min(
                    Double(date.timeIntervalSince(consumption.date)) / Double(kAlcoholAbsorptionTime), 1.0)
                * (1 - absorptionLoss)
                * calcAlcoholWeight(quantity: consumption.quantity, drinkUnit: consumption.unit, alcohol: consumption.alcohol)
        })
    }
    
    func generateRecords(session: Session) -> [RecordData] {
        var records = session.consumptions.flatMap({ (consumption) -> [RecordData] in
            [generateRecord(session: session, date: consumption.date),
             generateRecord(session: session, date: Date(timeIntervalSince1970: consumption.date.timeIntervalSince1970.advanced(by: kAlcoholAbsorptionTime)))]
        })
        let timeOfZeroBac = calcTimeOfZeroBAC(session)
        let currentTime = dateProvider.currentDate
        if (!session.consumptions.isEmpty) {
            records.append(RecordData(time: timeOfZeroBac, bacLevel: 0.0))
            if (timeOfZeroBac > currentTime
                && session.consumptions.min(by:
                    { (left, right) -> Bool in
                        left.date < right.date
                })!.date < currentTime) {
                records.append(generateRecord(session: session, date: currentTime))
            }
        }
        return records.sorted(by: { (left, right) -> Bool in
            left.time < right.time
        })
    }
    
    private func generateRecord(session: Session, date: Date) -> RecordData {
        return RecordData(time: date, bacLevel: calcBloodAlcoholConcentration(session: session, date: date))
    }
    
    private func getWeight(_ session: Session) -> Double {
        if (session.weight > 0) {
            return session.weight
        } else if (session.gender == Sex.MALE) {
            return kMaleAverageWeight
        } else {
            return kFemaleAverageWeight
        }
    }
}
