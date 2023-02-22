import Foundation

public enum ClubMemberError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])

    // MARK: - 400
    case kickMyself
    case delegationMyself

    // MARK: - 401
    case unauthorized

    // MARK: - 403
    case notClubHead
    case notClubMember

    // MARK: - 404
    case notFoundClub
    case notFoundKickUser
    case notFoundClubOrKickUser

    // MARK: - 500
    case serverError
}

extension ClubMemberError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .error(message, _):
            return message

        case .kickMyself:
            return "자기 자신은 방출할 수 없습니다"

        case .unauthorized, .serverError:
            return "알수없는 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."

        case .delegationMyself:
            return "자기 자신에게 부장을 위임할 수 없습니다"

        // MARK: - 403
        case .notClubHead:
            return "부장이 아니면 사용할 수 없습니다"

        case .notClubMember:
            return "동아리 구성원이 아니면 사용할 수 없습니다"

        // MARK: - 404
        case .notFoundClub:
            return "동아리를 찾을 수 없습니다"
            
        case .notFoundClubOrKickUser
            return "동아리를 찾을 수 없거나 방출하려는 유저를 찾을 수 없습니다."
        }
    }
}
