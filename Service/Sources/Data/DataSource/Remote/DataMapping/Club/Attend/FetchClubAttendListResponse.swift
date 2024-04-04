import Foundation

public struct FetchClubAttendListResponse: Decodable {
    let date: String?
    let period: String?
    let users: [UsersResponse]

    public struct UsersResponse: Decodable {
        public let uuid: UUID
        public let attendanceID: String
        public let name: String
        public let grade: Int
        public let classNum: Int
        public let number: Int
        public let attendanceStatus: AttendanceStatus
        
        enum CodingKeys: String, CodingKey, Decodable {
            case uuid
            case attendanceID = "attendanceId"
            case name
            case grade
            case classNum
            case number
            case attendanceStatus
        }
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
