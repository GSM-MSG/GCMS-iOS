import RxDataSources
import Service

struct StudentSection: SectionModelType {
    var items: [User]
}

extension StudentSection {
    typealias Item = User

    init(original: StudentSection, items: [User]) {
        self = original
        self.items = items
    }
}
