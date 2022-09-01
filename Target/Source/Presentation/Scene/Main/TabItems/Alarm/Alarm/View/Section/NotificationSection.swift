import RxDataSources
import UIKit

struct NotificationSection: SectionModelType {
    var items: [NotificationList]
    var date: String
}

extension NotificationSection {
    typealias Item = NotificationList
    
    init(original: NotificationSection, items: [NotificationList]) {
        self = original
        self.items = items
    }
}
