struct UserProfileResponse: Codable {
    let email: String
    let name: String
    let grade: Int
    let `class`: Int
    let num: Int
    let userImg: String?
    let requestJoin: [JoinedClubResponse]
}

extension UserProfileResponse {
    func toDomain() -> UserProfile {
        return .init(
            userId: email,
            profileImageUrl: userImg,
            name: name,
            grade: grade,
            class: `class`,
            number: num,
            joinedClub: requestJoin.map { $0.toDomain() }
        )
    }
}
