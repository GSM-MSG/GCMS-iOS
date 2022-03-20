import Foundation

extension String {
    func toDateWithISO8601() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.sss'Z'"
        return formatter.date(from: self) ?? .init()
    }
}

extension Date {
    func todayWithGMT() -> Date {
        return Date(timeInterval: TimeInterval(Calendar.current.timeZone.secondsFromGMT()), since: self)
    }
}
