import Foundation

public enum ClubApplicantError: Error {
    case error(message: String = "에러가 발생했습니다.", errorBody: [String: Any] = [:])

    // MARK: - 400
    case notClubMember
    case bodyIsNull

    // MARK: - 401
    case unauthorized

    // MARK: - 403
    case alreadyClubMemberOrSameTypeClub
    case notClubHead

    // MARK: - 404
    case notFoundClub
    case notFoundAcceptUserOrClub
    case notFoundRejectUserOrClub

    // MARK: - 500
    case serverError
}

extension ClubApplicantError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .error(message, _):
            return message
        case .notClubMember:
            return "동아리 구성원이 아니면 사용할 수 없습니다."

        case .bodyIsNull:
            return "요청이 잘못되었습니다"

        case .unauthorized, .serverError:
            return "알수없는 에러가 발생했습니다. 잠시 후 다시 시도해 주세요."

        case .alreadyClubMemberOrSameTypeClub:
            return "이미 같은 동아리 소속이거나 같은 타입의 동아리를 이미 신청했습니다."

        case .notClubHead:
            return "부장이 아니면 사용할 수 없습니다"

        case .notFoundClub:
            return "동아리를 찾을 수 없습니다."

        case .notFoundAcceptUserOrClub:
            return "수락하려는 유저를 찾을 수 없거나 동아리를 찾을 수 없습니다."

        case .notFoundRejectUserOrClub:
            return "거절하려는 유저를 찾을 수 없거나 동아리를 찾을 수 없습니다."
        }
    }
}
