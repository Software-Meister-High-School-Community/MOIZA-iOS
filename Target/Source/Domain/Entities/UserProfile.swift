
public struct UserProfile: Equatable {
    let userId: Int
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
        userId: .random(in: 0...1000),
        name: "김이름",
        school: .allCases.randomElement() ?? .dsm,
        scope: .allCases.randomElement() ?? .graduate,
        profileImageUrl: "https://avatars.githubusercontent.com/u/74440939?v=4",
        profileBackgroundColor: "#FFFFFF",
        introduce: "안녕하세요 제\n이름은 ...입니다\niOS만세이",
        linkUrl: [
            "https://github.com/baekteun",
            "https://www.google.com"
        ], feedCount: 3,
        followerCount: 99,
        followingCount: 248
    )
}
