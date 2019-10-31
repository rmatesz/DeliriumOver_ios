//
//  ConsumptionListRouter.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 09..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class ConsumptionListRouter {
    private final var viewController: UIViewController
    private final var storyboard: UIStoryboard
    
    init(_ viewController: UIViewController, _ storyboard: UIStoryboard) {
        self.viewController = viewController
        self.storyboard = storyboard
    }
    
    public func openConsumptionForm() {
        viewController.performSegue(withIdentifier: "openConsumptionForm", sender: viewController.navigationController)
    }
}
