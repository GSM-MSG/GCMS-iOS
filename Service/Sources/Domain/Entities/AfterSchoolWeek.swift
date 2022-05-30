public enum AfterSchoolWeek: String, Codable, CaseIterable {
    case monday = "MON"
    case tuesday = "TUE"
    case wednesday = "WED"
    case all = "ALL"
}

public extension AfterSchoolWeek {
    var display: String {
        switch self {
        case .monday: return "월요일"
        case .tuesday: return "화요일"
        case .wednesday: return "수요일"
        case .all: return "월요일, 화요일, 수요일"
        }
    }
    var segmentDisplay: String {
        switch self {
        case .monday: return "월요일"
        case .tuesday: return "화요일"
        case .wednesday: return "수요일"
        case .all: return "전체"
        }
    }
}
