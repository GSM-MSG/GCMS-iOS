import RxDataSources
import Service

struct ClubMemberSection: SectionModelType {
    let header: String
    var items: [User]
}

extension ClubMemberSection {
    typealias Item = User
    init(original: ClubMemberSection, items: [User]) {
        self = original
        self.items = items
    }
}
