import RxDataSources

struct FollowingSection: SectionModelType {
    var items: [UserList]
}

extension FollowingSection {
    typealias Item = UserList
    
    init(original: FollowingSection, items: [UserList]) {
        self = original
        self.items = items
    }
}