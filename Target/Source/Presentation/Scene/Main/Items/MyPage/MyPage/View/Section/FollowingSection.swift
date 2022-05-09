import RxDataSources

struct FollowingSection: SectionModelType {
    var items: [FollowerUserList]
}

extension FollowingSection {
    typealias Item = FollowerUserList
    
    init(original: FollowingSection, items: [FollowerUserList]) {
        self = original
        self.items = items
    }
}
