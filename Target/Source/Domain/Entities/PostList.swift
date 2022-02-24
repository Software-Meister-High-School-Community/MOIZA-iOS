import Foundation

struct PostList: Codable {
    let title: String
    let type: PostType
    let commentCount: Int
    let likeCount: Int
    let liked: Bool
}
