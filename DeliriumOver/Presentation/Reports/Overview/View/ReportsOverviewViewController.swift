//
//  FirstViewController.swift
//  DeliriumOver
//
//  Created by Mate on 2019. 01. 29..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import UIKit
import Charts
import CoreData
import RxSwift
import FirebaseDatabase
import FirebaseAuth
import SwinjectStoryboard
import KxMenu

class ReportsOverviewViewController: UIViewController {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "dd/MM/yyyy" }
    private static let timeFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    var viewModel: ReportOverviewViewModel!
    private var disposeBag: DisposeBag!
    private var addMenuItems = [AddMenuItem]()
    
    @IBOutlet weak var alcoholEliminationDate: UILabel!
    @IBOutlet weak var alcoholEliminationTime: UILabel!
    @IBOutlet weak var bacLevel: UILabel!
    @IBOutlet weak var sessionTitle: UITextField!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet var emptyState: [UIView]!
    @IBOutlet var contentState: [UIView]!
    weak var test: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        disposeBag = DisposeBag()
        viewModel.bacLevel.map { String(format: "%1.2f ‰", $0) }
            .bind(to: bacLevel.rx.text).disposed(by: disposeBag)
        viewModel.sessionTitle.bind(to: sessionTitle.rx.text).disposed(by: disposeBag)
        viewModel.alcoholEliminationDate.map { ReportsOverviewViewController.dateFormatter.string(from: $0) }
            .bind(to: alcoholEliminationDate.rx.text).disposed(by: disposeBag)
        viewModel.alcoholEliminationDate.map { ReportsOverviewViewController.timeFormatter.string(from: $0) }
            .bind(to: alcoholEliminationTime.rx.text).disposed(by: disposeBag)
        viewModel.chartData.subscribe { self.setupChart(stats: $0) }.disposed(by: disposeBag)
        emptyState.forEach { view in
            viewModel.chartData.map { !$0.filter { !$0.data.isEmpty }.isEmpty }
                .bind(to: view.rx.isHidden).disposed(by: disposeBag)
        }
        contentState.forEach { view in
            viewModel.chartData.map { $0.filter { !$0.data.isEmpty }.isEmpty }
                .bind(to: view.rx.isHidden).disposed(by: disposeBag)
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
    
    @IBAction func onEditBtnClicked() {
        startTitleEditing()
    }
    @IBAction func onSaveBtnClicked(_ sender: UIButton) {
        finishTitleEditing()
        guard let title = sessionTitle.text else { return }
        viewModel.onTitleEdited(title: title)
    }

    func setupChart(stats: [Record]) {
        let data = LineChartData()
        stats.filter { (record) -> Bool in
            !record.data.isEmpty
        }
        .map { (record) -> LineChartDataSet in
            createLineDataSet(stat: record)
        }.forEach { (dataSet) in
            data.addDataSet(dataSet)
        }
        data.setValueFormatter(ThousandthsValueFormatter())
        chart.xAxis.valueFormatter = DateAxisValueFormatter(formatString: "HH:mm")
        chart.data = data
    }

    private func startTitleEditing() {
        isEditing = true
        edit.isEnabled = false
        save.isEnabled = true
        sessionTitle.isEnabled = true
        sessionTitle.becomeFirstResponder()
    }
    
    private func finishTitleEditing() {
        isEditing = false
        edit.isEnabled = true
        save.isEnabled = false
        sessionTitle.isEnabled = false
    }

    private func createLineDataSet(stat: Record) -> LineChartDataSet {
        let entries = stat.data.map { (record) -> ChartDataEntry in
            ChartDataEntry(x: record.time.timeIntervalSince1970 as Double, y: record.bacLevel)
        }
        return LineChartDataSet(entries: entries, label: stat.name)
    }
    
}

extension ReportsOverviewViewController {

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
