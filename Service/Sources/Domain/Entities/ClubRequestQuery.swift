public struct ClubRequestQuery: Encodable {
    public init(name: String, type: ClubType) {
        self.name = name
        self.type = type
    }
    
    public let name: String
    public let type: ClubType
}
