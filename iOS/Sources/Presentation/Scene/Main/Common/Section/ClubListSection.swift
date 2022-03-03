import UIKit
import RxDataSources
import Service

struct ClubListSection: SectionModelType {
    let header: String
    var items: [ClubList]
}

extension ClubListSection {
    typealias Item = ClubList
    init(original: ClubListSection, items: [ClubList]) {
        self = original
        self.items = items
    }
}
