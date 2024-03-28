import Foundation

struct FetchClubAttendListResponse: Decodable {
    let date: String?
    let period: Period?
    let users: [UsersResponse]

    struct UsersResponse: Decodable {
        let uuid: UUID
        let attendanceID: String
        let name: String
        let grade: Int
        let classNum: Int
        let number: Int
        let attendanceStatus: AttendanceStatus
    }
}

extension FetchClubAttendListResponse.UsersResponse {
    func toDomain() -> ClubAttend {
        ClubAttend(
            uuid: uuid,
            attendanceID: attendanceID,
            name: name,
            grade: grade,
            classNum: classNum,
            number: number,
            attendanceStatus: attendanceStatus
        )
    }
}

extension FetchClubAttendListResponse {
    func toDomain() -> [ClubAttend] {
        self.users.map { $0.toDomain() }
    }
}
