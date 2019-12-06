//
//  SessionFormPresenterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 05..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol SessionFormPresenter {
    func saveSession(name: String, weight: Float, gender: Sex)
}
