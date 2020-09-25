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

class ReportsOverviewViewController: UIViewController {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "dd/MM/yyyy" }
    private static let timeFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    var viewModel: ReportOverviewViewModel!
    private var disposeBag: DisposeBag!
    
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
