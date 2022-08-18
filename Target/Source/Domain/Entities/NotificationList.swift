import Foundation

struct NotificationList: Equatable {
    let id: String
    let title: String
    let content: String
    let topic: Topic
    let data: Int
    let isRead: Bool
    let createdAt: Date?
}
