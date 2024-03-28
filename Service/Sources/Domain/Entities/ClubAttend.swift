import Foundation

public struct ClubAttend: Equatable {
    public let uuid: UUID
    public let attendanceID: String
    public let name: String
    public let grade: Int
    public let classNum: Int
    public let number: Int
    public let attendanceStatus: AttendanceStatus
    
    public init(
        uuid: UUID,
        attendanceID: String,
        name: String,
        grade: Int,
        classNum: Int,
        number: Int,
        attendanceStatus: AttendanceStatus
    ) {
        self.uuid = uuid
        self.attendanceID = attendanceID
        self.name = name
        self.grade = grade
        self.classNum = classNum
        self.number = number
        self.attendanceStatus = attendanceStatus
    }
}
