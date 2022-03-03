import Foundation
import RxDataSources

public struct Alarm: Equatable {
    public init(id: Int, name: String, content: String) {
        self.id = id
        self.name = name
        self.content = content
    }
    
    public let id: Int
    public let name: String
    public let content: String
}

extension Alarm: IdentifiableType {
    public var identity: String {
        return UUID().uuidString
    }
}
