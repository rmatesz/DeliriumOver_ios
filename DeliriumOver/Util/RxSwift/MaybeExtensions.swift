//
//  MaybeExtensions.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 10. 06..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

extension Maybe {
    static func from<Element>(_ callable: @escaping () throws -> Element?) -> Maybe<Element> {
        return Maybe<Element>.create { (observer: @escaping (MaybeEvent<Element>) -> Void) -> Disposable in
            do {
                if let result = try callable() {
                    observer(.success(result))
                } else {
                    observer(.completed)
                }
            } catch {
                observer(.error(error))
            }
            return Disposables.create()
        }
    }
}
