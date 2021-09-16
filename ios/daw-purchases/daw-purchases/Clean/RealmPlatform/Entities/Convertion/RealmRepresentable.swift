import Foundation

protocol RealmRepresentable {
    associatedtype RealmType: RealmDomainConvertibleType

    var uid: String {get}

    func asRealm() -> RealmType
}
