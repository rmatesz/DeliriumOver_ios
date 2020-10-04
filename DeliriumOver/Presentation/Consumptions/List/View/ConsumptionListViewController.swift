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
import RxSwift

class ConsumptionListViewController: UIViewController {

    var viewModel: ConsumptionListViewModel!
    private var consumptionListTableViewController: ConsumptionListTableViewController?
    private var addMenuItems = [AddMenuItem]()
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet var emptyState: [UIView]!
    private var disposeBag: DisposeBag!

    override func viewDidAppear(_ animated: Bool) {
        disposeBag = DisposeBag()
        viewModel.consumptions.map { $0.isEmpty }.bind(to: listContainer.rx.isHidden).disposed(by: disposeBag)
        emptyState.forEach { view in
            viewModel.consumptions.map { !$0.isEmpty }.bind(to: view.rx.isHidden).disposed(by: disposeBag)
        }
        viewModel.drinks.map {
            var menuItems = $0.map { (drink) -> MenuItem in
                MenuItem(title: drink.name, entity: drink)
            }
            menuItems.append(MenuItem(title: "Add new...", entity: nil))
            return menuItems
        }.subscribe { self.updateAddMenuItems(menuItems: $0) }.disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        disposeBag = nil
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ConsumptionListTableViewController"?:
            consumptionListTableViewController = segue.destination as? ConsumptionListTableViewController
            consumptionListTableViewController?.viewModel = viewModel
        case .none:
            break
        case .some:
            break
        }
    }

    private func updateAddMenuItems(menuItems: [MenuItem]) {
        addMenuItems = menuItems.map({ (menuItem) -> AddMenuItem in
            AddMenuItem(menuItem, image: UIImage.init(), target: self, action: #selector(onAddItemSelected(_:)))
        })
    }

    @IBAction func onAddClicked(_ sender: UIButton) {
        if (addMenuItems.isEmpty) {
            performSegue(withIdentifier: "ShowConsumptionForm", sender: self)
        } else {
            KxMenu.show(in: self.view.window,
                        from: CGRect(x: sender.frame.origin.x,
                                     y: sender.frame.origin.y,
                                     width: sender.frame.width,
                                     height: sender.frame.height),
                        menuItems: addMenuItems)
        }
    }

    @objc private func onAddItemSelected(_ sender: AddMenuItem) {
        guard let drink = sender.menuItem.entity as? Drink else {
            performSegue(withIdentifier: "ShowConsumptionForm", sender: self)
            return
        }

        viewModel.addDrinkAsConsumption(drink: drink)
            .subscribe()
            .disposed(by: disposeBag)
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

struct MenuItem {
    var title: String
    var entity: Any?
}
