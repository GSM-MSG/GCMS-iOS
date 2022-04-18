struct UserProfileResponse: Codable {
    let userData: UserDTO
    let clubs: [ClubListDTO]
}

extension UserProfileResponse {
    func toDomain() -> UserProfile {
        return .init(
            userId: userData.email,
            profileImageUrl: userData.userImg,
            name: userData.name,
            grade: userData.grade,
            class: userData.`class`,
            number: userData.num,
            joinedClub: clubs.map { $0.toDomain() }
        )
    }
}
