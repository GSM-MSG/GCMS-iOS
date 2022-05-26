public struct AfterSchool: Equatable {
    public let name: String
    public let season: String
    public let week: String
    public let grade: Int
    
    public init(
        name: String,
        season: String,
        week: String,
        grade: Int
    ) {
        self.name = name
        self.season = season
        self.week = week
        self.grade = grade
    }
}

