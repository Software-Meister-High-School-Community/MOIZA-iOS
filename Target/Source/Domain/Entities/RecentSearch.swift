import Foundation

public struct RecentSearch: Equatable {
    let id: Int
    let keyword: String
}

extension RecentSearch {
    static var dummy: RecentSearch {
        RecentSearch(
            id: .random(in: 1...100),
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
