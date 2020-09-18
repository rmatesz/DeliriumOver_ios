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

class ReportsOverviewViewController: UIViewController, ReportOverviewView {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "dd/MM/yyyy" }
    private static let timeFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    var presenter: ReportOverviewPresenter!
    
    @IBOutlet weak var alcoholEliminationDate: UILabel!
    @IBOutlet weak var alcoholEliminationTime: UILabel!
    @IBOutlet weak var bacLevel: UILabel!
    @IBOutlet weak var sessionTitle: UITextField!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var chart: LineChartView!
    weak var test: UILabel!
    
    override func viewDidLoad() {
        presenter.start()
    }
    
    @IBAction func onEditBtnClicked() {
        startTitleEditing()
    }
    @IBAction func onSaveBtnClicked(_ sender: UIButton) {
        finishTitleEditing()
        guard let title = sessionTitle.text else { return }
        presenter.onTitleEdited(title: title)
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

