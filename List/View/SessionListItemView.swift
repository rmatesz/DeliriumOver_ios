//
//  SessionlistItemView.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 04..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class SessionListItemView : UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var inProgress: UILabel!
    
    func update(sessionListItem: SessionListItem) {
        title.text = sessionListItem.title
        inProgress.alpha = sessionListItem.inProgress ? 1.0 : 0.0
    }
}
