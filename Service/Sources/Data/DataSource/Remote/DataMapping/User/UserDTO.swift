struct UserDTO: Codable {
    let userId: String
    let name: String
    let profileImageUrl: String?
    let grade: Int
    let `class`: Int
    let number: Int
    let joinedMajorClub: ClubListDTO?
    let joinedFreedomClub: ClubListDTO?
    let joinedEditorialClub: [ClubListDTO]
    
    enum CodingKeys: String, CodingKey {
        case userId, name, grade, `class`, number, joinedMajorClub, joinedFreedomClub, joinedEditorialClub
        case profileImageUrl = "userImg"
    }
}

extension UserDTO {
    func toDomain() -> User {
        return .init(
            userId: userId,
            profileImageUrl: profileImageUrl,
            name: name,
            grade: grade,
            class: `class`,
            number: number,
            joinedMajorClub: joinedMajorClub?.toDomain(),
            joinedFreedomClub: joinedFreedomClub?.toDomain(),
            joinedEditorialClub: joinedEditorialClub.map { $0.toDomain() }
        )
    }
}
