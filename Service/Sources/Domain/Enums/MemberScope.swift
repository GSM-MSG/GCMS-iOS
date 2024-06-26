public enum MemberScope: String, Codable {
    case member = "MEMBER"
    case head = "HEAD"
    case `default` = "USER"
    case other = "OTHER"
    case admin = "ADMIN"
}
