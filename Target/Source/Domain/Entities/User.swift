
struct User: Equatable {
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
