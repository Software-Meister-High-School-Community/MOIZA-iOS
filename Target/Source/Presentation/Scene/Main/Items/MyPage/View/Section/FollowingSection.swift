import RxDataSources

struct FollowingSection: SectionModelType {
    let header: String
    var items: [UserList]
}

extension FollowingSection {
    typealias Item = UserList
    
    init(original: FollowingSection, items: [UserList]) {
        self = original
        self.items = items
    }
}
