import Foundation

extension String {
    func toDateWithISO8601() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd`T`HH:mm:ss"
        formatter.locale = Locale(identifier: "Ko_Kr")
        return formatter.date(from: self) ?? .init()
    }
}
