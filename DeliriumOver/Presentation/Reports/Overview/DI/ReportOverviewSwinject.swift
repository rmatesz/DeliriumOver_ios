//
//  ReportOverviewSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class ReportsOverviewSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.storyboardInitCompleted(ReportsOverviewViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(ReportOverviewPresenter.self)
        }
        
        defaultContainer.register(ReportOverviewPresenter.self) { (resolver) -> ReportOverviewPresenter in
            ReportOverviewPresenterImpl()
        }
    }
}
