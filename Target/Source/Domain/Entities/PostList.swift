import Foundation

struct PostList {
    let id: Int
    let title: String
    let type: PostType
    let isLike: Bool
    let commentCount: Int
    let likeCount: Int
    let viewCount: Int
    let createdAt: Date
}

extension PostList {
    static let dummy = PostList(
        id: .random(in: 0...100),
        title: "대충 제목",
        type: .allCases.randomElement(),
        isLike: true,
        commentCount: 4,
        likeCount: 8,
        viewCount: 12,
        createdAt: Date()
    )
}
