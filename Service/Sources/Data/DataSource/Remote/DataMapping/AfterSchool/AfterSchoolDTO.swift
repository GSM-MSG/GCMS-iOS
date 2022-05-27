import Foundation

struct AfterSchoolDTO: Codable {
    let id: Int
    let title: String
    let week: AfterSchoolWeek
    let grade: Int
    let personnel: Int
    let maxPersonnel: Int
    let isOpened: Bool
}
