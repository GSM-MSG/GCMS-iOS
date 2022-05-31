import Foundation
import RealmSwift

public enum QueryFilter<T: Object> {
    case string(query: String)
    case predicate(query: NSPredicate)
    case `where`(query: ((Query<T>) -> Query<Bool>))
}
