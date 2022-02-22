import Foundation

struct Post: Codable {
    let title: String
    let type: PostType
    let commentCount: Int
    let likeCount: Int
}
