import UIKit
import RxDataSources

struct ClubActivitySection: SectionModelType {
    var items: [Data]
}

extension ClubActivitySection {
    typealias Item = Data
    
    init(original: ClubActivitySection, items: [Data]) {
        self = original
        self.items = items
    }
}
