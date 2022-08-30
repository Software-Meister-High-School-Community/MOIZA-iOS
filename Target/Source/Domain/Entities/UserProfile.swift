import Foundation

public struct UserProfile: Equatable {
    let userId: String
    let name: String
    let school: School
    let scope: UserScope
    let profileImageUrl: String
    let profileBackgroundColor: String
    let introduce: String?
    let linkUrl: [String]?
    let feedCount: Int
    let followerCount: Int
    let followingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case name, school, introduce
        case userId = "user_id"
        case scope = "user_scope"
        case profileImageUrl = "profile_image_url"
        case profileBackgroundColor = "profile_background_color"
        case linkUrl = "link_url"
        case feedCount = "feed_count"
        case followerCount = "follower_count"
        case followingCount = "following_count"
    }
}

extension UserProfile {
    static let dummy = UserProfile(
        userId: UUID().uuidString,
        name: ["김성훈", "최형우", "김상은", "남화진인"].randomElement() ?? "",
        school: .allCases.randomElement() ?? .dsm,
        scope: .allCases.randomElement() ?? .graduate,
        profileImageUrl: [
            "https://avatars.githubusercontent.com/u/91456952?s=100&v=4",
            "https://avatars.githubusercontent.com/u/85563909?s=100&v=4",
            "https://avatars.githubusercontent.com/u/80795917?s=100&v=4",
            "https://avatars.githubusercontent.com/u/67373938?v=4"
        ].randomElement() ?? "",
        profileBackgroundColor: [
            "#123456",
            "#371253",
            "#F836DS",
            "#F2SV83"
        ].randomElement() ?? "",
        introduce: [
            "안녕하세요 제\n이름은 김이름입니다\niOS만세이",
            "저는 사용자에게 최고의 경험을 제공할 수 있는 개발자로 성장하고 싶습니다.",
            "Github 1 Day 1 Commit 을 진행하고 있으며, 개발 블로그를 운영하며 학습내용을 정리하고 있습니다.",
            "믿을 수 있는 듬직한 동료가 목표인 iOS 개발자 한상진입니다.\n끊임없이 더 나은 것에 대하여 고민하고 개선하려 노력합니다.",
        ].randomElements().joined(separator: "\n"),
        linkUrl: [
            "https://github.com/baekteun",
            "https://www.google.com",
            "https://github.com/Software-Meister-High-School-Community/MOIZA-iOS",
            "https://apps.apple.com/kr/app/gcms/id1616315883"
        ].randomElements(), feedCount: .random(in: 0...300),
        followerCount: .random(in: 0...500),
        followingCount: .random(in: 0...1200)
    )
}
