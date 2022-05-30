public struct ClubRequestQuery: Encodable {
    public init(name: String, type: ClubType) {
        self.q = name
        self.type = type
    }
    
    public let q: String
    public let type: ClubType
}
