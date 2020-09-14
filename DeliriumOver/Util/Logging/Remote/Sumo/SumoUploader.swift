//
//  SumoUploader.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 08..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class SumoUploader: LogUploader {
    func upload(logs: [LogModel]) -> Completable {
        return Completable.create { (observer) -> Disposable in
            var request = URLRequest(url: URL(string: "https://collectors.de.sumologic.com/receiver/v1/http/ZaVnC4dhaV1Vqs1htaKOQCrOrwU7SWJ_O9EASVzl6Ne26HUzg30P4WAHwo2S5XMTkhj9OuK0TleTl5PkEkBT3onl7pcfJS4OrqgKeo5UXU0PBdMeBU00iw==")!)
            request.httpMethod = "POST"
            request.httpBody = logs.map { $0.toString() }.reduce("", { (result, log) -> String in
                result + "\n\(log)"
            }).data(using: .utf8)

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.error(error))
                } else {
                    observer(.completed)
                }
            }

            task.resume()
            return Disposables.create()
        }
    }
}

fileprivate extension LogModel {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: self.timestamp))
        return "\(date): [\(category)] \(message)" + (error != nil ? "\n\(error)" : "")
    }
}
