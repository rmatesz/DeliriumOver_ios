//
//  SessionListView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation

protocol SessionListView: class {
    func displaySessions(sessions: [SessionListItem])
}
