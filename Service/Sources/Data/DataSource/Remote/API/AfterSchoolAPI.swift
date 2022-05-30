import Moya

enum AfterSchoolAPI {
    case afterSchoolList(query: AfterSchoolQuery)
    case apply(afterSchoolId: Int)
    case cancel(afterSchoolId: Int)
    case find(name: String, query: AfterSchoolQuery)
}

extension AfterSchoolAPI: GCMSAPI {
    
    var domain: GCMSDomain {
        return .afterSchool
    }
    var urlPath: String {
        switch self {
        case .afterSchoolList:
            return ""
        case .apply:
            return "/apply"
        case .cancel:
            return "/cancel"
        case .find:
            return "/find"
        }
    }
    var method: Method {
        switch self {
        case .afterSchoolList, .find:
            return .get
        case .apply:
            return .post
        case .cancel:
            return .delete
        }
    }
    var task: Task {
        switch self {
        case let .afterSchoolList(query):
            return .requestParameters(parameters: [
                "season": query.season.rawValue,
                "week": query.week.rawValue,
                "grade": query.grade
            ], encoding: URLEncoding.queryString)
        case let .apply(afterSchoolId), let .cancel(afterSchoolId):
            return .requestJSONEncodable(afterSchoolId)
        case let .find(name, query):
            return .requestParameters(parameters: [
                "name": name,
                "season": query.season.rawValue,
                "week": query.week.rawValue,
                "grade": query.grade
            ], encoding: URLEncoding.queryString)
        }
    }
    var jwtTokenType: JWTTokenType? {
        switch self {
        default:
            return .accessToken
        }
    }
    var errorMapper: [Int: GCMSError]?{
        return [:]
    }
}
