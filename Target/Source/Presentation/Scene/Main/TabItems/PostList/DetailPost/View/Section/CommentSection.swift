import RxDataSources

struct CommentSection: SectionModelType {
    var items: [Comment]
}

extension CommentSection {
    typealias Item = Comment
    
    init(original: CommentSection, items: [Comment]) {
        self = original
        self.items = items
    }
}
