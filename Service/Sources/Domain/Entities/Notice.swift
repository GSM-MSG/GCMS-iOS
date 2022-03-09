public struct Notice: Equatable {
    public init(id: Int, club: String, content: String, isInvite: Bool, clubId: Int) {
        self.id = id
        self.club = club
        self.content = content
        self.isInvite = isInvite
        self.clubId = clubId
    }
    
    public let id: Int
    public let club: String
    public let content: String
    public let isInvite: Bool
    public let clubId: Int
    
}
