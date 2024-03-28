public enum AttendanceStatus: String, Codable {
    case attendance = "ATTENDANCE"
    case late = "LATE"
    case reasonableAbsent = "REASONABLE_ABSENT"
    case absent = "ABSENT"
}
