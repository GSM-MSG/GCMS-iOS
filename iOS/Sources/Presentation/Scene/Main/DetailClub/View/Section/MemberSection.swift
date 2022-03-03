import RxDataSources
import Service

struct MemberSection: SectionModelType {
    let header: String
    var items: [User]
}

extension MemberSection {
    typealias Item = User
    init(original: MemberSection, items: [User]) {
        self = original
        self.items = items
    }
}
