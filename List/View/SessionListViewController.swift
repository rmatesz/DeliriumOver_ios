//
//  SessionListViewController.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class SessionListViewController : UITableViewController, SessionListView {
    var presenter: SessionListPresenter!
    
    private var sessionItems: [SessionListItem] = []
    private var sessions: [SessionListItem]
    {
        get {
            return sessionItems
        }
        set {
            sessionItems = newValue
            tableView.reloadData()
        }
    }

    func displaySessions(sessions: [SessionListItem]) {
        self.sessions = sessions
    }
    
    override func viewDidLoad() {
        presenter.start()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionListItemView", for: indexPath) as! SessionListItemView
        
        cell.update(sessionListItem: sessions[indexPath.row])
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            presenter?.onConsumptionSwiped(index: indexPath.row)
//        }
//    }
}
