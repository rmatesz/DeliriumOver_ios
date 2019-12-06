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
            container.register(SessionListView.self, factory: { (resolver) -> SessionListView in
                controller
            })
            container.register(UIViewController.self, factory: { (resolver) -> UIViewController in
                controller
            })
            container.register(UIStoryboard.self, factory: { (resolver) -> UIStoryboard in
                controller.storyboard!
            })
            controller.presenter = resolver.resolve(SessionListPresenter.self)
        }
        
        container.register(SessionListPresenter.self) { (resolver) -> SessionListPresenter in
            SessionListPresenterImpl(view: resolver.resolve(SessionListView.self)!, interactor: resolver.resolve(SessionListInteractor.self)!)
        }
        
        container.register(SessionListInteractor.self) { (resolver) -> SessionListInteractor in
            SessionListInteractorImpl(sessionRepository: resolver.resolve(SessionRepository.self)!)
        }
    }
}
