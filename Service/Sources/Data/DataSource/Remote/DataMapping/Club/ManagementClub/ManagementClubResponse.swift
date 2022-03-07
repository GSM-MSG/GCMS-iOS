
struct ManagementClubResponse: Codable {
    let list: [ManagementClubResponseDTO]
}

extension ManagementClubResponse {
    func toDomain() -> [ClubList] {
        return self.list.map { $0.toDomain() }
    }
}
