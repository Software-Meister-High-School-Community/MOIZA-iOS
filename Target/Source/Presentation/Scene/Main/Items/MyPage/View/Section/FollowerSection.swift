import RxDataSources

struct FollowerSection: SectionModelType {
    let header: String
    var items: [UserList]
}

extension FollowerSection {
    typealias Item = UserList
    
    init(original: FollowerSection, items: [UserList]) {
        self = original
        self.items = items
    }
}
