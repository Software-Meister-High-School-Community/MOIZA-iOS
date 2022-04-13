import RxDataSources

struct FollowerSection: SectionModelType {
    var items: [UserList]
}

extension FollowerSection {
    typealias Item = UserList
    
    init(original: FollowerSection, items: [UserList]) {
        self = original
        self.items = items
    }
}
