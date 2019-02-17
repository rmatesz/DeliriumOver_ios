//
//  SecondViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import KxMenu
import FirebaseDatabase
import FirebaseAuth

class ConsumptionListViewController: UIViewController, ConsumptionListView {
    
    var presenter: ConsumptionListPresenter?
    private var consumptionListTableViewController: ConsumptionListTableViewController?
    private var addMenuItems = [AddMenuItem]()
    
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

    func updateAddMenuItems(menuItems: [MenuItem]) {
        addMenuItems = menuItems.map({ (menuItem) -> AddMenuItem in
            AddMenuItem(menuItem, image: UIImage.init(), target: self, action: #selector(onAddItemSelected(_:)))
        })
    }
    
    @IBAction func onAddClicked(_ sender: UIButton) {
        if (addMenuItems.isEmpty) {
            presenter?.onAddClicked()
        } else {
            KxMenu.show(in: view,
                        from: sender.superview!.superview!.frame,
                        menuItems: addMenuItems)
        }
        
    }

    @objc private func onAddItemSelected(_ sender: AddMenuItem) {
        presenter?.onMenuItemSelected(menuItem: sender.menuItem)
    }

    class AddMenuItem: KxMenuItem {
        let menuItem: MenuItem
        init(_ menuItem: MenuItem, image: UIImage!, target: AnyObject, action: Selector) {
            self.menuItem = menuItem
            super.init()
            super.title = menuItem.title
            super.image = image
            super.target = target
            super.action = action
        }
    }
}

