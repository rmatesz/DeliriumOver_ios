//
//  SessionListInteractor.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

protocol SessionListViewModel {
    var sessions: Observable<[Session]> { get }
}
