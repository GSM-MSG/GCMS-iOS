import Foundation

extension String {
    func toDateWithISO8601() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.sss'Z'"
        formatter.locale = Locale(identifier: "Ko_Kr")
        return formatter.date(from: self) ?? .init()
    }
}
