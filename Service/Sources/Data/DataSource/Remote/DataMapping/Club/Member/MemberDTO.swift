import Foundation

struct MemberDTO: Codable {
    let email: String
    let name: String
    let grade: Int
    let `class`: Int
    let num: Int
    let userImg: String?
}
