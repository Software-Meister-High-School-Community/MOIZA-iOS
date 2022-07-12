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

extension Post {
    static var dummy: Post {
        Post(
            author: .dummy,
            title: [
                "이러이럴때 침착하게 대응하는 방~법",
                "마법학교 앞점멸 천재가 되었다.",
                "마왕의 아카데미",
                "회귀자도 못 깬 탑 등반합니다",
                "깨진 유리창 이론",
                "회귀한 천재 플레이어의 신화급 무기창조",
                "마법학교 마법사로 살아가는 법"
            ].randomElement() ?? "",
            content: [
                "프론트 엔드 학개론 리액트하세요 넥스트하세요 코드를 깔끔하게 쓰세요. 프론트 엔드 학개론 리액트하세요 넥스트하세요 코드를 깔끔하게 쓰세요",
                "이것은 내용입니다. 이런 저런 아무튼 많은게 있을 뿐이죠. 그래서 이 내용은 사실 아무 의미도 없는 내용입니다. 무슨 내용을 반복하여서 글을 채워야 할지 작성자는 너무 힘듭니다. 살려주세요.",
                "애플문서에는 Declares that a type can transmit a sequence of values over time. 이라고 정의되어있구요 구독자와 같은 하나이상의 관계자에게 시간이 지남에 따라 값을 보낼 수 있는 타입 이라고 설명할 수 있겠네요 관심 있는 값이나 이벤트를 (publish)게시할 수 있죠 간단하게 동작을 보자면 1. 관심있는 값에 구독을 걸고 2. 그 값에 새 이벤트가 발생하면(값이 변경되면) 3. 비동기식으로 이벤트(값)을 전달 받을 수 있습니다."
            ].randomElement() ?? "",
            imageUrls: [
                "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
                "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80076029?v=4"
            ].randomElements(),
            createdAt: Date(),
            feedType: .allCases.randomElement() ?? .normal,
            isMine: .random(),
            isUpdated: false,
            likeCount: .random(in: 0...5000),
            viewCount: .random(in: 0...2000),
            comments: [
                .dummy, .dummy, .dummy
            ].randomElements()
        )
    }
}
