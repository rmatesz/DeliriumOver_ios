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

class ReportsOverviewViewController: UIViewController, ReportOverviewView {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "dd/MM/yyyy" }
    private static let timeFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    var presenter: ReportOverviewPresenter!

    @IBOutlet weak var alcoholEliminationDate: UILabel!
    @IBOutlet weak var alcoholEliminationTime: UILabel!
    @IBOutlet weak var bacLevel: UILabel!
    @IBOutlet weak var sessionTitle: UITextField!

    override func viewDidLoad() {
        presenter.start()
    }
    
    @IBAction func onSaveBtnClicked(_ sender: UIButton) {
        if isEditing {
            finishTitleEditing()
        } else {
            startTitleEditing()
        }
    }
    
    func update(sessionTitle: String) {
        self.sessionTitle.text = sessionTitle
    }
    
    func update(bacLevel: Float) {
        self.bacLevel.text = String(format: "%1.2f ‰", bacLevel)
    }
    
    func update(alcoholEliminationDate: Date) {
        self.alcoholEliminationDate.text = ReportsOverviewViewController.dateFormatter.string(from: alcoholEliminationDate)
        self.alcoholEliminationTime.text = ReportsOverviewViewController.timeFormatter.string(from: alcoholEliminationDate)
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

