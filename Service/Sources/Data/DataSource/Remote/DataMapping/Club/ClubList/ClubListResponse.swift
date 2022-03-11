
struct ClubListResponse: Codable {
    let list: [ClubListDTO]
}

extension ClubListResponse {
    func toDomain() -> [ClubList] {
        return list.map { $0.toDomain() }
    }
}
