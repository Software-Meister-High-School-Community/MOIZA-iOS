import Foundation

struct NoticeList: Equatable {
    let id: String
    let title: String
    let createdAt: Date
    let isPinned: Bool
}

extension NoticeList {
    static var dummy: NoticeList {
        NoticeList(
            id: UUID().uuidString,
            title: [
                "모이자와 함께하기 위해서는",
                "자고 싶어요 자고 싶다구요",
                "모이자와 함께하기"
            ].randomElement() ?? "",
            createdAt: Date(),
            isPinned: .random())
    }
}
