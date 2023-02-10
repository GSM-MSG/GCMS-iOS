struct UserMyProfileResponse: Codable {
    let userData: UserDTO
    let clubs: [ClubListDTO]
}

extension UserMyProfileResponse {
    func toDomain() -> UserProfile {
        return .init(uuid: userData.uuid,
                     email: userData.email,
                     name: userData.name,
                     grade: userData.grade,
                     classNum: userData.classNum,
                     number: userData.number,
                     profileImg: userData.profileImg ?? "",
                     clubs: clubs.map { $0.toDomain() })
    }
}
