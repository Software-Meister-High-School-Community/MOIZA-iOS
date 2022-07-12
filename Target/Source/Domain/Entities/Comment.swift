import Foundation

struct Comment: Equatable {
    let id: Int
    let author: Author
    let isMine: Bool
    let isPinned: Bool
    let createdAt: Date
    let content: String
    let likeCount: Int
    let imageUrls: [String]?
    let childComments: [ChildComment]?
}

extension Comment {
    static var dummy: Comment {
        Comment(
            id: .random(in: 0...500),
            author: .dummy,
            isMine: .random(),
            isPinned: false,
            createdAt: Date(),
            content: [
                "댓글입니다댓글입니다\n댓글입니다댓글입니다",
                "많고많은 댓글중 하나의 더미 댓글 입니다. 많고많은 댓글중 하나의 더미 댓글 입니다. 많고많은 댓글중 하나의 더미 댓글 입니다.",
                "아 이거 이렇게 하는거 아닌데",
                "이거 이렇게하면 간단하게 해결될거같은데요? 아"
            ].randomElement() ?? "",
            likeCount: .random(in: 0...300),
            imageUrls: [
                "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
                "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80076029?v=4"
            ].randomElements(),
            childComments: [
                .dummy, .dummy, .dummy, .dummy, .dummy, .dummy, .dummy
            ].randomElements()
        )
    }
}
