import Foundation
import RxSwift
import RxCocoa


//extension ObservableType {
//    func mapToVoid() -> Observable<Void> {
//        return map { _ in }
//    }
//}


extension Observable where Element: Sequence, Element.Iterator.Element: CoreDataDomainConvertibleType {
    typealias CoreDataDomainType = Element.Iterator.Element.DomainType
    
    func mapToDomain() -> Observable<[CoreDataDomainType]> {
        return map { sequence -> [CoreDataDomainType] in
            return sequence.mapToDomain()
        }
    }
}

extension Sequence where Iterator.Element: CoreDataDomainConvertibleType {
    typealias CoreDataElement = Iterator.Element
    func mapToDomain() -> [CoreDataElement.DomainType] {
        return map {
            return $0.asDomain()
        }
    }
}



//extension ObservableType where Element == Bool {
//    /// Boolean not operator
//    public func not() -> Observable<Bool> {
//        return self.map(!)
//    }
//
//}
//
//extension SharedSequenceConvertibleType {
//    func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
//        return map { _ in }
//    }
//}
//
//extension ObservableType {
//
//    func catchErrorJustComplete() -> Observable<Element> {
//        return catchError { _ in
//            return Observable.empty()
//        }
//    }
//
//    func asDriverOnErrorJustComplete() -> Driver<Element> {
//        return asDriver { error in
//            return Driver.empty()
//        }
//    }
//
//    func mapToVoid() -> Observable<Void> {
//        return map { _ in }
//    }
//}
