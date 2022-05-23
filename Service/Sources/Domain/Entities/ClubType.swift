
public enum ClubType: String, Codable, CaseIterable {
    case major = "MAJOR"
    case editorial = "EDITORIAL"
    case freedom = "FREEDOM"
}

public extension ClubType {
    var display: String {
        switch self {
        case .major: return "전공"
        case .freedom: return "자율"
        case .editorial: return "사설"
        }
    }
}
