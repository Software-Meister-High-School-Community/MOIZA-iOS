import Foundation

struct Post: Equatable {
    let author: Author
    let title: String
    let content: String
    let imageUrls: [String]?
    let createdAt: Date
    let feedType: PostType
    let isMine: Bool
    let isUpdated: Bool
    let likeCount: Int
    let viewCount: Int
    let comments: [Comment]
}
