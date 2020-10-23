//
//  SessionListSwinject.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class SessionListSwinject {
    class func setup(_ container: Container) {
        container.storyboardInitCompleted(SessionListViewController.self) { (resolver, controller) in
            container.register(UIViewController.self, factory: { (resolver) -> UIViewController in
                controller
            })
            container.register(UIStoryboard.self, factory: { (resolver) -> UIStoryboard in
                controller.storyboard!
            })
            controller.viewModel = resolver.resolve(SessionListViewModel.self)
        }
        
        container.register(SessionListViewModel.self) { (resolver) -> SessionListViewModel in
            SessionListViewModelImpl(sessionRepository: resolver.resolve(SessionRepository.self)!)
        }
    }
}
