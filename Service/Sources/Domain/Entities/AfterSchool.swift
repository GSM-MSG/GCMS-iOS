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

