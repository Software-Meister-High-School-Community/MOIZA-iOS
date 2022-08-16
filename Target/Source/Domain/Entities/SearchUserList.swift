import Foundation

struct SearchUserList: Equatable {
    let userId: String
    let name: String
    let profileImageUrl: String
    let userType: UserScope
    let school: School
}

extension SearchUserList {
    static var dummy: SearchUserList {
        SearchUserList(
            userId: UUID().uuidString,
            name: ["김성훈", "최형우", "김상은", "남화진인"].randomElement() ?? "",
            profileImageUrl: [
                "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
                "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
                "https://avatars.githubusercontent.com/u/67373938?v=4"
            ].randomElement() ?? "",
            userType: .allCases.randomElement() ?? .graduate,
            school: .allCases.randomElement() ?? .gsm
        )
    }
}
