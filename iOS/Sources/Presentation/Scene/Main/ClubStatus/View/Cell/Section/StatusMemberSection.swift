import RxDataSources
import Service

struct StatusMemberSection: SectionModelType {
    var items: [Member]
}

extension StatusMemberSection {
    typealias Item = Member
    
    init(original: StatusMemberSection, items: [Member]) {
        self = original
        self.items = items
    }
}
