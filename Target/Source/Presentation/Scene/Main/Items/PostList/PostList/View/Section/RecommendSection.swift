import RxDataSources

struct RecommendSection: SectionModelType {
    let header: String
    var items: [PostList]
}

extension RecommendSection {
    typealias Item = PostList
    
    init(original: RecommendSection, items: [PostList]) {
        self = original
        self.items = items
    }
    var identity: String {
        return UUID().uuidString
    }
}
