import RxDataSources
import Service

struct ApplicantSection: SectionModelType {
    let header: String
    var items: [User]
}

extension ApplicantSection {
    typealias Item = User
    init(original: ApplicantSection, items: [User]) {
        self = original
        self.items = items
    }
}
