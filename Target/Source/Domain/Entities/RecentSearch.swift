import Foundation

public struct RecentSearch: Equatable {
    let id: String
    let keyword: String
}

extension RecentSearch {
    static var dummy: RecentSearch {
        RecentSearch(
            id: UUID().uuidString,
            keyword: [
                "맥북",
                "리액트",
                "넥스트",
                "클린 아키텍쳐",
                "ㅈㄱㅊㅇ ㅈㅈ"
            ].randomElement() ?? ""
        )
    }
}
