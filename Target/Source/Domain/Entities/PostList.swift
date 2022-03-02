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
