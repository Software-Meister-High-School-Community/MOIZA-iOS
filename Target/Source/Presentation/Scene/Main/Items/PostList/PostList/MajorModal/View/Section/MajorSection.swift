import RxDataSources

struct MajorSection: SectionModelType {
    let header: String
    var items: [Major]
}

extension MajorSection {
    typealias Item = Major
    
    init(original: MajorSection, items: [Major]) {
        self = original
        self.items = items
    }
}
