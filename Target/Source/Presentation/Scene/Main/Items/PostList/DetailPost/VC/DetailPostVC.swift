import UIKit

final class DetailPostVC: baseVC<DetailPostReactor> {
    // MARK: - Properties
    private let headerView = UIView()
    
    // MARK: - UI
    override func configureNavigation() {
        self.navigationItem.configBack()
        self.navigationItem.setTitleWithSubTitle(
            title: UserDefaultsLocal.shared.major.rawValue,
            subtitle: "질문 게시판"
        )
    }
}
