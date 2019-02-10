//
//  SecondViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ConsumptionListViewController: UIViewController, ConsumptionListView {
    var presenter: ConsumptionListPresenter?
    private var consumptionListTableViewController: ConsumptionListTableViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.start()
    }
    
    func displayConsumptionList(consumptions: [ConsumptionListItem]) {
        consumptionListTableViewController?.consumptions = consumptions
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ConsumptionListTableViewController"?:
            consumptionListTableViewController = segue.destination as? ConsumptionListTableViewController
                break
        case .none:
            break
        case .some(_):
            break
        }
    }

    
}

