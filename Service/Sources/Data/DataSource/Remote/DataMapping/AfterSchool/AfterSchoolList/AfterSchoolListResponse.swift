struct AfterSchoolListResponse: Codable {
    let afterSchool: AfterSchoolDTO
    let isApplied: Bool
}

extension AfterSchoolListResponse {
    func toDomain() -> AfterSchool {
        return .init(
            id: afterSchool.id,
            title: afterSchool.title,
            week: afterSchool.week,
            grade: afterSchool.grade,
            personnel: afterSchool.personnel,
            maxPersonnel: afterSchool.maxPersonnel,
            isOpened: afterSchool.isOpened,
            isApplied: isApplied
        )
    }
}
