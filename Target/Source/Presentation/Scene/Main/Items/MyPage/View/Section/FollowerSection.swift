import RxDataSources

struct FollowerSection: SectionModelType {
    let header: String
    var items: [Follow]
}

extension FollowerSection {
    typealias Item = Follow
    
    init(original: FollowerSection, items: [Follow]) {
        self = original
        self.items = items
    }
}
