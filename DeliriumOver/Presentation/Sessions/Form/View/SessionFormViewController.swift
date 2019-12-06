//
//  SessionFormViewController.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 05..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class SessionFormViewControlelr : UIViewController {
    var presenter: SessionFormPresenter!
    
    func onSaveFinished() {
        // TODO: hide progress
    }
    
    @IBAction func onSaveClicked(_ sender: Any) {
        presenter.saveSession(name: "", weight: 85, gender: Sex.MALE)
        // TODO: show progress
    }

    @IBAction func onCancelClicked(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
    }
}
