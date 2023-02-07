import Moya

enum ClubMemberAPI {
    case clubMember(query: ClubRequestQuery)
    case userKick(query: ClubRequestQuery, userId: String)
    case delegation(query: ClubRequestQuery, userId: String)
}

extension ClubMemberAPI: GCMSAPI {
    var urlPath: String {
        <#code#>
    }
    
    var errorMapper: [Int : GCMSError]? {
        <#code#>
    }
    
    var method: Moya.Method {
        <#code#>
    }
    
    var task: Moya.Task {
        <#code#>
    }
    
    var jwtTokenType: JWTTokenType? {
        <#code#>
    }
    
    var domain: GCMSDomain {
           return .club
       }
}
