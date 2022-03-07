import RxDataSources
import Service

struct AddedUserSection: SectionModelType {
    var items: [User]
}

extension AddedUserSection {
    typealias Item = User
    init(original: AddedUserSection, items: [User]) {
        self = original
        self.items = items
    }
}
