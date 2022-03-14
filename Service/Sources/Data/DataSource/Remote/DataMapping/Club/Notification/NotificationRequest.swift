import Foundation

public struct NotificationRequest: Encodable {
    let noticeType: NoticeType
    let content: String
}
