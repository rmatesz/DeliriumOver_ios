//
//  SessionFormViewController.swift
//  DeliriumOver
//
//  Created by Mate Redecsi on 2019. 12. 05..
//  Copyright © 2019. rmatesz. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SessionFormViewController : UIViewController {
    var presenter: SessionFormViewModel!

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    private var disposeBag: DisposeBag!
    private var loadingIndicator: LoadingIndicator!

    override func viewDidLoad() {
        loadingIndicator = LoadingIndicator(frame: view.frame)
    }

    override func viewDidAppear(_ animated: Bool) {
        let genders = [Sex.MALE, Sex.FEMALE]
        disposeBag = DisposeBag()
        presenter.name.bind(to: name.rx.text).disposed(by: disposeBag)
        name.rx.text.orEmpty.bind(to: presenter.name).disposed(by: disposeBag)
        presenter.weight.bind(to: weight.rx.text).disposed(by: disposeBag)
        weight.rx.text.orEmpty.bind(to: presenter.weight).disposed(by: disposeBag)
        presenter.gender.map { genders.index(of: $0) ?? 0 }.bind(to: gender.rx.selectedSegmentIndex).disposed(by: disposeBag)
        gender.rx.selectedSegmentIndex.map { genders[$0] }.bind(to: presenter.gender).disposed(by: disposeBag)
    }

    override func viewDidDisappear(_ animated: Bool) {
        disposeBag = nil
    }

    @IBAction func onSaveClicked(_ sender: Any) {
        presenter.saveSession()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler())
            .do(onSubscribed: {
                self.view.addSubview(self.loadingIndicator!)
            })
            .subscribe(
                onCompleted: {
                    self.loadingIndicator.removeFromSuperview()
                    self.presentingViewController?.dismiss(animated: true) },
                onError: { _ in
                    self.loadingIndicator.removeFromSuperview()
                    let alert = UIAlertController(title: "Error!", message: "Unable to save session. Please try again!", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default))
                    self.present(alert, animated: true, completion: nil)
                }
            )
            .disposed(by: disposeBag)
    }
}

extension SessionFormViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let formatter = NumberFormatter()
        let candidate = (textField.safeText as NSString).replacingCharacters(in: range, with: string)
        let separator = formatter.decimalSeparator!

        return candidate.isEmpty || candidate.range(of: "^[0-9]+([\(separator)][0-9]*)?$", options: .regularExpression) != nil
    }
}
