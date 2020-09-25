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
    private final let presentingViewController: Lazy<UIViewController>
    
    init(presentingViewController: Lazy<UIViewController>) {
        self.presentingViewController = presentingViewController
    }
    
    func finish() {
        presentingViewController.instance.dismiss(animated: true)
    }
}
