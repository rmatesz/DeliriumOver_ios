//
//  SessionListViewController.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class SessionListViewController : UITableViewController {
    var viewModel: SessionListViewModel!

    private let disposeBag = DisposeBag()
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
    
    override func viewDidLoad() {
        viewModel.sessions
            .subscribe { sessions in
                self.sessions = sessions.map { SessionListItem(title: $0.title, inProgress: $0.inProgress) }
            }
            .disposed(by: disposeBag)
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
}
