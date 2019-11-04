//
//  ReportOverviewView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 11. 02..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol ReportOverviewView: class {
    func update(sessionTitle: String)
    func update(bacLevel: Float)
    func update(alcoholEliminationDate: Date)
}
