public struct AfterSchool: Equatable {
    
    public init(id: Int, title: String, week: AfterSchoolWeek, grade: Int, personnel: Int, maxPersonnel: Int, isOpened: Bool, isApplied: Bool) {
        self.id = id
        self.title = title
        self.week = week
        self.grade = grade
        self.personnel = personnel
        self.maxPersonnel = maxPersonnel
        self.isOpened = isOpened
        self.isApplied = isApplied
    }
    
    public let id: Int
    public let title: String
    public let week: AfterSchoolWeek
    public let grade: Int
    public let personnel: Int
    public let maxPersonnel: Int
    public let isOpened: Bool
    public let isApplied: Bool
}

public extension AfterSchool {
    static let dummy = AfterSchool(
        id: 0,
        title: "컴퓨터 활용능력",
        week: AfterSchoolWeek.monday,
        grade: 1,
        personnel: 17,
        maxPersonnel: 30,
        isOpened: true,
        isApplied: true
    )
}
