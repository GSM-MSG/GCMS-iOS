import Moya

enum ClubAPI {
    case newClub(req: NewClubRequest)
    case manageList
}

extension ClubAPI: GCMSAPI {
    var domain: GCMSDomain {
        return .club
    }
    var urlPath: String {
        switch self {
        case .newClub:
            return "/write"
        case .manageList:
            return "/list/manage"
        }
    }
    var method: Method {
        switch self {
        case .newClub:
            return .post
        case .manageList:
            return .get
        }
    }
    var task: Task {
        switch self {
        case let .newClub(req):
            return .requestParameters(parameters: [
                "photo": req.photo,
                "type": req.type.rawValue,
                "name": req.name,
                "description": req.description,
                "teacher": req.teacher,
                "head": req.head,
                "discord": req.discord,
                "clubPhoto": req.clubPhoto,
                "clubMember": req.clubMember
            ], encoding: JSONEncoding.default)
        case .manageList:
            return .requestPlain
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        case .newClub, .manageList:
            return .accessToken
        }
    }
}
