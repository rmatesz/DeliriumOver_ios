//
//  ConsumptionFormRouterImpl.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 09. 18..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class ConsumptionFormRouterImpl: ConsumptionFormRouter {
    private final let navigationController: Lazy<UINavigationController>
    
    init(navigationController: Lazy<UINavigationController>) {
        self.navigationController = navigationController
    }
    
    func finish() {
        navigationController.instance.popViewController(animated: true)
    }
}
