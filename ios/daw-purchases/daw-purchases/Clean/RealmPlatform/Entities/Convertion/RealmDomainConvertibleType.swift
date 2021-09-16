import Foundation

protocol RealmDomainConvertibleType {
    associatedtype DomainType

    func asDomain() -> DomainType
}
