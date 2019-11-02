//
//  FirstViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import CoreData
import RxSwift
import FirebaseDatabase
import FirebaseAuth
import SwinjectStoryboard

class ReportsOverviewViewController: UIViewController {
    var presenter: ReportOverviewPresenter!

    @IBOutlet weak var alcoholEliminationDate: UILabel!
    @IBOutlet weak var bacLevel: UILabel!
    @IBOutlet weak var sessionTitle: UITextField!

    @IBAction func onSaveBtnClicked(_ sender: UIButton) {
        if isEditing {
            finishTitleEditing()
        } else {
            startTitleEditing()
        }
    }
    
    private func startTitleEditing() {
        isEditing = true
        sessionTitle.isEnabled = true
        sessionTitle.becomeFirstResponder()
    }
    
    private func finishTitleEditing() {
        isEditing = false
        sessionTitle.isEnabled = false
        presenter.onTitleEdited(title: sessionTitle.text ?? "")
    }
    
}

