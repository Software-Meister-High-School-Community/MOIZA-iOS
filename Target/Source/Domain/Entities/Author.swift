import Foundation
struct Author: Equatable {
    let id: String
    let profileImageUrl: String
    let name: String
    let schoolName: School
    let type: UserScope
}

extension Author {
    static var dummy: Author {
        Author(
            id: UUID().uuidString,
            profileImageUrl: [
                "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
                "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
                "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
                "https://avatars.githubusercontent.com/u/67373938?v=4"
            ].randomElement() ?? "",
            name: ["김성훈", "최형우", "김상은", "남화진인"].randomElement() ?? "",
            schoolName: .allCases.randomElement() ?? .dgsm,
            type: .allCases.randomElement() ?? .student
        )
    }
}
