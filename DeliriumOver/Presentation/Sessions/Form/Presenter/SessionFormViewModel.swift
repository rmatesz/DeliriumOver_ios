import Foundation
import RxSwift
import RxCocoa

protocol SessionFormViewModel {
    var name: BehaviorRelay<String> { get }
    var weight: BehaviorRelay<String> { get }
    var gender: BehaviorRelay<Sex> { get }
    func saveSession() -> Completable
}
