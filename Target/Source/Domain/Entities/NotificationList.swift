import Foundation

struct NotificationList: Equatable {
    let id: String
    let title: String
    let content: String
    let topic: Topic
    let data: String
    let isRead: Bool
    let createdAt: Date
}

extension NotificationList {
    static var dummy: NotificationList {
        NotificationList(
            id: UUID().uuidString,
            title: [
                "회원님의 졸업생 인증이 끝마쳐졌습니다.",
                "변찬우님이 회원님을 팔로우했습니다."
            ].randomElement() ?? "",
            content: "변찬우님이 회원님을 팔로우했습니다.",
            topic: .follow,
            data: UUID().uuidString,
            isRead: true,
            createdAt: [
                Date(),
                Date().addingTimeInterval(-68400)
            ].randomElement() ?? .init()
        )
    }
}
