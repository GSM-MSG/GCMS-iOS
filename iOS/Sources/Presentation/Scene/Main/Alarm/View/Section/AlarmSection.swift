import RxDataSources
import Service
import Foundation

struct AlarmSection: SectionModelType {
    let header: String
    var items: [Alarm]
}

extension AlarmSection {
    typealias Item = Alarm
    init(original: AlarmSection, items: [Alarm]) {
        self = original
        self.items = items
    }
}
