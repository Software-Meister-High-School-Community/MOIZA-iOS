import Foundation

struct ChildComment: Equatable {
    let id: Int
    let parentCommentId: Int
    let author: Author
    let isMine: Bool
    let likeCount: Int
    let imageUrls: [String]
    let createdAt: Date
    let content: String
}

extension ChildComment {
    static var dummy: ChildComment {
        ChildComment(
            id: .random(in: 0...300),
            parentCommentId: .random(in: 0...500),
            author: .dummy,
            isMine: .random(),
            likeCount: .random(in: 0...3000),
            imageUrls: [
                "https://avatars.githubusercontent.com/u/81547954?s=70&v=4",
                "https://avatars.githubusercontent.com/u/3011832?s=100&v=4",
                "https://avatars.githubusercontent.com/u/102890390?s=100&v=4",
                "https://avatars.githubusercontent.com/u/65935582?s=100&v=4"
            ].randomElements(),
            createdAt: .init(timeIntervalSinceNow: .init(Int.random(in: -128600...128600))),
            content: [
                "프론트 엔드 학개론 리액트하세요 넥스트하세요 코드를 깔끔하게 쓰세요. 프론트 엔드 학개론 리액트하세요 넥스트하세요 코드를 깔끔하게 쓰세요",
                "이것은 내용입니다. 이런 저런 아무튼 많은게 있을 뿐이죠. 그래서 이 내용은 사실 아무 의미도 없는 내용입니다. 무슨 내용을 반복하여서 글을 채워야 할지 작성자는 너무 힘듭니다. 살려주세요.",
                "애플문서에는 Declares that a type can transmit a sequence of values over time. 이라고 정의되어있구요 구독자와 같은 하나이상의 관계자에게 시간이 지남에 따라 값을 보낼 수 있는 타입 이라고 설명할 수 있겠네요 관심 있는 값이나 이벤트를 (publish)게시할 수 있죠 간단하게 동작을 보자면 1. 관심있는 값에 구독을 걸고 2. 그 값에 새 이벤트가 발생하면(값이 변경되면) 3. 비동기식으로 이벤트(값)을 전달 받을 수 있습니다."
            ].randomElement() ?? "")
    }
}
