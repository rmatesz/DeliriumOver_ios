//
//  ConsumptionListTableViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 02. 10..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit

class ConsumptionListTableViewController: UITableViewController {
    var presenter: ConsumptionListPresenter?
    
    private var consumptionItems: [ConsumptionListItem] = []
    var consumptions: [ConsumptionListItem]
    {
        get {
            return consumptionItems
        }
        set {
            consumptionItems = newValue
            tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumptions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsumptionListItemView", for: indexPath) as! ConsumptionListItemView
        
        cell.update(consumption: consumptions[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter?.onConsumptionSwiped(index: indexPath.row)
        }
    }

}
