public enum AfterSchoolSeason: String, Codable, CaseIterable {
    case first = "FIRST"
    case second = "SECOND"
    case summer = "SUMMER"
    case winter = "WINTER"
}

public extension AfterSchoolSeason {
    var display: String {
        switch self {
        case .first: return "1학기"
        case .second: return "2학기"
        case .summer: return "여름방학"
        case .winter: return "겨울방학"
        }
    }
}
