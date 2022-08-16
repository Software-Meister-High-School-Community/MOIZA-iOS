
struct FollowingUserListDTO: Decodable {
    let userID: String
    let name: String
    let profileImageURL: String
    let school: School
    let userScope: UserScope
    let isFollow: Bool

    enum CodingKeys: String, CodingKey {
        case school,name
        case userID = "user_id"
        case profileImageURL = "profile_image_url"
        case userScope = "user_scope"
        case isFollow = "is_follow"
    }
}
extension FollowingUserListDTO{
    func toDomain() -> FollowerUserList{
        return .init(userID: userID,
                     name: name,
                     profileImageUrl: profileImageURL,
                     school: school,
                     userScope: userScope,
                     isFollow: isFollow)
    }
}
