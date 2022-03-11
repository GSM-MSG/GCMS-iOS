import RxSwift

struct UserNoticeResponse: Codable {
    let list: [NoticeDTO]
}

extension UserNoticeResponse {
    func toDomain() -> [Notice] {
        return self.list.map { $0.toDomain() }
    }
}
