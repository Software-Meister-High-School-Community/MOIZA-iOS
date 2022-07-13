import Foundation

struct PostList: Equatable {
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
    static var dummy: PostList {
        PostList(
            id: .random(in: 0...100),
            title: [
                "이러이럴때 침착하게 대응하는 방~법",
                "마법학교 앞점멸 천재가 되었다.",
                "마왕의 아카데미",
                "회귀자도 못 깬 탑 등반합니다",
                "깨진 유리창 이론",
                "회귀한 천재 플레이어의 신화급 무기창조",
                "마법학교 마법사로 살아가는 법"
            ].randomElement() ?? "",
            type: .allCases.randomElement() ?? .normal,
            isLike: .random(),
            commentCount: .random(in: 0...300),
            likeCount: .random(in: 0...400),
            viewCount: .random(in: 0...500),
            createdAt: Date()
        )
    }
}
