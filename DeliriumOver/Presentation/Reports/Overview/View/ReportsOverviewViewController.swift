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
import MaterialTapTargetPrompt_iOS
import SwinjectStoryboard
import KxMenu

class ReportsOverviewViewController: UIViewController {
    private static let dateFormatter = DateFormatter().apply { $0.dateFormat = "dd/MM/yyyy" }
    private static let timeFormatter = DateFormatter().apply { $0.dateFormat = "HH:mm" }
    var viewModel: ReportOverviewViewModel!
    private var disposeBag: DisposeBag!
    private var addConsumptionDecorator: AddConsumptionDecorator?
    
    @IBOutlet weak var alcoholEliminationDate: UILabel!
    @IBOutlet weak var alcoholEliminationTime: UILabel!
    @IBOutlet weak var bacLevel: UILabel!
    @IBOutlet weak var sessionTitle: UITextField!
    @IBOutlet weak var edit: UIButton!
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var chart: LineChartView!
    @IBOutlet weak var addDrinkBtn: UIButton!
    @IBOutlet var emptyState: [UIView]!
    @IBOutlet var contentState: [UIView]!
    weak var test: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        disposeBag = DisposeBag()
        addConsumptionDecorator = AddConsumptionDecorator(viewController: self, viewModel: viewModel)
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
        viewModel.onboardingTrigger
            .filter { !$0.isEmpty }
            .subscribe { onboarding in self.displayOnboarding(onboarding[0]) }
            .disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        addConsumptionDecorator = nil
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

    private func displayOnboarding(_ onboarding: OnboardingManager.Onboarding) {
        switch onboarding {
        case .setupSessionData:
            performSegue(withIdentifier: "ShowSessionForm", sender: self)
            viewModel.setOnboardingDone(onboarding)
        case .disclaimer:
            let alert = UIAlertController(title: "Delirium Over!", message: "The data displayed by the application is informational. All measurements are an average for a healthy (healthy liver) person. It highly depends on the actual state of mind, emptyness of stomach and drinking habits. If you'd like to drive, wait more than the displayed degradation time, before you can safely sit in the car.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { _ in
                self.viewModel.setOnboardingDone(onboarding)
            }))
            present(alert, animated: true, completion: nil)
        case .manageConsumptions:
            let targetView = (tabBarController?.tabBar.subviews.filter { String(describing: $0).contains("UITabBarButton") })![1]
            let tapTargetPrompt = MaterialTapTargetPrompt(target: targetView)
            tapTargetPrompt.action = {
                self.viewModel.setOnboardingDone(onboarding)
                self.tabBarController?.selectedIndex = 1
            }
            tapTargetPrompt.dismissed = {
                self.viewModel.setOnboardingDone(onboarding)
            }
            tapTargetPrompt.circleColor = UIColor(red: 0.204, green: 0.467, blue: 0.396, alpha: 1)
            tapTargetPrompt.primaryText = ""
            tapTargetPrompt.secondaryText = "You can always check and manage your previously registered consumptions"
            tapTargetPrompt.textPostion = .centerTop
        case .addConsumption:
            let tapTargetPrompt = MaterialTapTargetPrompt(target: addDrinkBtn)
            tapTargetPrompt.action = {
                self.viewModel.setOnboardingDone(onboarding)
                self.addDrinkBtn.sendActions(for: .touchUpInside)
            }
            tapTargetPrompt.dismissed = {
                self.viewModel.setOnboardingDone(onboarding)
            }
            tapTargetPrompt.circleColor = UIColor(red: 0.204, green: 0.467, blue: 0.396, alpha: 1)
            tapTargetPrompt.primaryText = "Start adding consumptions"
            tapTargetPrompt.secondaryText = "You can add new consumption any time"
            tapTargetPrompt.textPostion = .topLeft
        }
    }

    @IBAction func onAddClicked(_ sender: UIButton) {
        addConsumptionDecorator?.addConsumption(sender: sender)
    }
}

extension ReportsOverviewViewController: AddConsumptionViewController {
    func openAddConsumptionForm() {
        performSegue(withIdentifier: "ShowConsumptionForm", sender: self)
    }
}
