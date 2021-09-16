import Foundation
import CoreData
import RxSwift
import QueryKit

protocol Persistable: NSFetchRequestResult, CoreDataDomainConvertibleType {
    static var entityName: String {get}
    static func fetchRequest() -> NSFetchRequest<Self>
}

extension Persistable {
    static var primaryAttribute: Attribute<String> {
        return Attribute("uid")
    }
}
