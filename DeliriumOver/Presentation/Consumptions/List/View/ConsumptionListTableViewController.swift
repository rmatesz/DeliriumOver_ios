//
//  ConsumptionListTableViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ConsumptionListTableViewController: UITableViewController {
    var viewModel: ConsumptionListViewModel!
    private var disposeBag: DisposeBag!

    private var consumptionItems: [ConsumptionListItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 90
    }

    override func viewWillAppear(_ animated: Bool) {
        disposeBag = DisposeBag()
        viewModel.consumptions
            .map {
                $0.map { (consumption) -> ConsumptionListItem in
                    ConsumptionListItem(drink: consumption.drink,
                                        alcohol: String(format: "%.01f%%", consumption.alcohol*100),
                                        quantity: String(format: "%.01f %@", consumption.quantity, consumption.unit.label()),
                                        date: consumption.date,
                                        consumption: consumption)
                }

            }
            .subscribe { self.consumptionItems = $0 }
            .disposed(by: disposeBag)
    }

    override func viewWillDisappear(_ animated: Bool) {
        disposeBag = nil
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumptionItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsumptionListItemView",
                                                 for: indexPath) as! ConsumptionListItemView
        cell.update(consumption: consumptionItems[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(consumption: consumptionItems[indexPath.row].consumption)
                .subscribe()
                .disposed(by: disposeBag)
        }
    }

}
