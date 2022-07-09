import RxDataSources

struct FollowingSection: SectionModelType {
    var items: [FollowingUserList]
}

extension FollowingSection {
    typealias Item = FollowingUserList
    
    init(original: FollowingSection, items: [FollowingUserList]) {
        self = original
        self.items = items
    }
}
