import RxDataSources

struct FollowerSection: SectionModelType {
    var items: [FollowerUserList]
}

extension FollowerSection {
    typealias Item = FollowerUserList
    
    init(original: FollowerSection, items: [FollowerUserList]) {
        self = original
        self.items = items
    }
}
