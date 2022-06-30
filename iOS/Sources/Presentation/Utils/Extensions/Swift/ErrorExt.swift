import Foundation
import Service

extension Error {
    var asGCMSError: GCMSError? {
        return self as? GCMSError
    }
}
