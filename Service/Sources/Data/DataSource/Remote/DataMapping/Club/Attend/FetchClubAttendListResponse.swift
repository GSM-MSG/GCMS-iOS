import Foundation
import

struct FetchClubAttendResponse: Decodable {
    let date: String?
    let period: Period?
    let users: [UsersResponse]
    
    struct UsersResponse: Decodable {
        let id: UUID
        let attendanceId: String
        let name: String
        let grade: Int
        let classNum: Int
        let number: Int
        let attendanceStatus: AttendanceStatus
    }
}

extension FetchClubAttendResponse.UsersResponse {
    func toDomain() -> {
        
    }
}

extension FetchClubAttendResponse {
    func toDomain() -> {
        
    }
}
