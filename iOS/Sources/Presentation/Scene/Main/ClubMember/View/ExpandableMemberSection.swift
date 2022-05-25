import RxDataSources
import Service

enum MemberSectionType {
    case member(Member)
    case applicant(User)
}

struct ExpandableMemberSection {
    var header: String
    var items: [MemberSectionType]
    var isOpened: Bool
}
