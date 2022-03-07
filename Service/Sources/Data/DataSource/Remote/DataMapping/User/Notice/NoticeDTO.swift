
struct NoticeDTO: Codable {
    let id: Int
    let club: String
    let content: String
    let isInvite: Bool
    let clubId: Int
}

extension NoticeDTO {
    func toDomain() -> Notice {
        return .init(
            id: self.id,
            club: self.club,
            content: self.content,
            isInvite: self.isInvite,
            clubId: self.clubId
        )
    }
}
