public struct LoginRequest {
    public init(idToken: String, deviceToken: String) {
        self.idToken = idToken
        self.deviceToken = deviceToken
    }
    
    public let idToken: String
    public let deviceToken: String
}
