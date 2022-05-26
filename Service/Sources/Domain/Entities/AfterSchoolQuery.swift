public struct AfterSchoolQuery: Encodable {
    public init(season: AfterSchoolSeason, week: AfterSchoolWeek, grade: Int) {
        self.season = season
        self.week = week
        self.grade = grade
    }
    
    public let season: AfterSchoolSeason
    public let week: AfterSchoolWeek
    public let grade: Int
}
