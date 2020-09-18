//
//  FIleLogger.swift
//  DeliriumOver
//
//  Created by mate.redecsi on 2020. 09. 08..
//  Copyright © 2020. rmatesz. All rights reserved.
//

import Foundation
import RxSwift

class RemoteLogger: ILogger {
    private let repository: LogRepository
    private let disposeBag = DisposeBag()
    private var uploaders: [LogUploader] = []

    init(repository: LogRepository) {
        self.repository = repository

        repository.logs
            .filter { self.needLogUpload(logs: $0) }
            .flatMap { self.upload(logs: $0).andThen(self.repository.clear()) }
            .subscribe()
        .disposed(by: disposeBag)
    }

    func handleLog(logLevel: LogLevel, tag: String?, category: String?, message: String?, error: Error?) {
        repository.store(model: LogModel(timestamp: Date().timeIntervalSince1970, category: category, level: logLevel, message: message, error: error?.localizedDescription))
            .subscribe()
            .disposed(by: disposeBag)
    }

    func attach(uploader: LogUploader) {
        uploaders.append(uploader)
    }

    private func needLogUpload(logs: [LogModel]) -> Bool {
        return logs.count > 500 || logs.contains { $0.level == LogLevel.ERROR  }
    }

    private func upload(logs: [LogModel]) -> Completable {
        return Completable.concat(uploaders.map { (uploader) -> Completable in
            uploader.upload(logs: logs)
        })
    }
}

protocol LogUploader {
    func upload(logs: [LogModel]) -> Completable
}
