import RxDataSources
import Service
import Foundation

struct AlarmSection: AnimatableSectionModelType {
    let header: String
    var items: [Alarm]
}

extension AlarmSection: IdentifiableType {
    typealias Item = Alarm
    init(original: AlarmSection, items: [Alarm]) {
        self = original
        self.items = items
    }
    
    var identity: String {
        return UUID().uuidString
    }
}
