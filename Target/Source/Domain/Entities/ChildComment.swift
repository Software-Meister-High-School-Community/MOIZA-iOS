import Foundation
struct ChildComment {
    let id: Int
    let parentCommentId: Int
    let author: Author
    let isMine: Bool
    let likeCount: Int
    let imageUrls: [String]
    let createdAt: Date
    let content: String
}
