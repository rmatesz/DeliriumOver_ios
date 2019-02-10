//
//  CoreDataSwinject.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import Swinject

class CoreDataSwinject {
    class func setup(defaultContainer: Container) {
        defaultContainer.register(SessionDAO.self) { (resolver) -> SessionDAO in
            SessionDAOImpl()
        }
        
        defaultContainer.register(ConsumptionDAO.self) { (resolver) -> ConsumptionDAO in
            ConsumptionDAOImpl()
        }
    }
}
