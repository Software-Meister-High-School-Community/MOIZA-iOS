import RxDataSources

struct RecentSearchSection: SectionModelType {
    var items: [RecentSearch]
}

extension RecentSearchSection {
    typealias Item = RecentSearch
    
    init(original: RecentSearchSection, items: [RecentSearch]) {
        self = original
        self.items = items
    }
}
