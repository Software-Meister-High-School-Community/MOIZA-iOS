
enum SortType: String, Codable, CaseIterable {
    case latest = "LATEST"
    case like = "LIKE-COUNT"
    case old = "OLDEST"
    case view = "VIEW-COUNT"
}
