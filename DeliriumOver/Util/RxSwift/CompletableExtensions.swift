//
//  CompletableExtensions.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 06..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

extension Completable {
    static func from(_ action: @escaping () throws -> Void) -> Completable {
        return Completable.create { (observer) -> Disposable in
            do {
                try action()
                observer(.completed)
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
