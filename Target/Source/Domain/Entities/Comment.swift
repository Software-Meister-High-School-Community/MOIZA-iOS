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


